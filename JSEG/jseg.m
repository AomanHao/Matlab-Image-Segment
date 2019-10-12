function varargout = jseg(varargin)
% JSEG MATLAB code for jseg.fig
%      JSEG, by itself, creates a new JSEG or raises the existing
%      singleton*.
%
%      H = JSEG returns the handle to a new JSEG or the handle to
%      the existing singleton*.
%
%      JSEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JSEG.M with the given input arguments.
%
%      JSEG('Property','Value',...) creates a new JSEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before jseg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to jseg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jseg

% Last Modified by GUIDE v2.5 22-Apr-2017 22:23:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jseg_OpeningFcn, ...
                   'gui_OutputFcn',  @jseg_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before jseg is made visible.
function jseg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to jseg (see VARARGIN)

% Choose default command line output for jseg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);
imshow([255]);
axes(handles.axes2);
imshow([255]);
axes(handles.axes3);
imshow([255]);
axes(handles.axes4);
imshow([255]);
axes(handles.axes5);
imshow([255]);
axes(handles.axes6);
imshow([255]);
axes(handles.axes7);
imshow([255]);
axes(handles.axes8);
imshow([255]);
axes(handles.axes9);
imshow([255]);
axes(handles.axes10);
imshow([255]);
% UIWAIT makes jseg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jseg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global pic%全局变量

axes(handles.axes1)%声明窗体1显示图片
[filename,pathname]=uigetfile({ ...%声明一个文件选择对话框
    '*.*','All Files(*.*)';},...
    '选择文件');
%
if isequal([filename,pathname],[0,0])%如果获取的文件名是空的话，说明打开失败
    return%打开失败，程序返回
else
    
    videoname = fullfile(pathname,filename);%构造选择文件的获取路径
    mov=imread(videoname);%读入选择的图片
   imshow(mov);%显示图片
   pic=mov;  %图片矩阵赋值给全局变量
   title('原始图像');%显示图片标题

    %handle.axes1=b;
end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global pic;
image_org = pic;
[m,n,d] = size(image_org);
% figure; imshow(image_org);

%====== partition ========%
% class_map from clustering algorithms
X = reshape(double(image_org), m*n,d);
[tmp,M,tmp2,P] = kmeansO(X,[],16,0,0,0,0);
map = reshape(P, m, n);

% quantized image 
ImgQ = class2Img(map, image_org);
axes(handles.axes2);
imshow(uint8(ImgQ));
title('图像量化');

% generate J images
    for w = 1:4,
        W = GenerateWindow(w);
        JI = JImage(map, W,w);
        save([num2str(w) '.mat'], 'JI');
        imwrite(JI, ['JImage' num2str(w) '.jpg']);
    end

%===== load existing J-images ===%   
load('4.mat');
JI4 = JI;
load('3.mat');
JI3 = JI;
load('2.mat');
JI2 = JI;
load('1.mat');
JI1 = JI;
axes(handles.axes3);
imshow(JI1);
title('9*9窗口生成J图');
axes(handles.axes4);
imshow(JI1);
title('17*17窗口生成J图');
axes(handles.axes5);
imshow(JI1);
title('33*33窗口生成J图');
axes(handles.axes6);
imshow(JI1);
title('65*65窗口生成J图');



Region = zeros(m, n);
% --------------------scale 4--------------------
% scale 4
u = mean(JI4(:));
s = std(JI4(:));
Region = ValleyD(JI4,  4, u, s); % 4.1 Valley Determination
Region = ValleyG1(JI4, Region);  % 4.2.2 Growing
Region = ValleyG1(JI3, Region);  % 4.2.3 Growing at next smaller scale
Region = ValleyG2(JI1, Region);  % 4.2.4 remaining pixels at the smallest scale
Region4 = Region;
fprintf('scale4: %d\n', max(Region(:)));
% draw segments
axes(handles.axes7);imshow(uint8(ImgQ));title('区域生长结果1');
hold on;
DrawLine(Region);
hold off;
% --------------------scale 3--------------------
w = 3;
    Region = SpatialSeg(JI3, Region, w);
    % Valley Growing at the next smaller scale level
    Region = ValleyG1(JI2, Region);
    % Valley Growing at the smallest scale level
    Region = ValleyG2(JI1, Region);
    Region3 = Region;
    fprintf('scale3: %d\n', max(Region(:)));
axes(handles.axes8);imshow(uint8(ImgQ));title('区域生长结果2');
hold on;
DrawLine(Region);
hold off;
% --------------------scale 2--------------------
% SpatialSeg includes one ValleyD and ValleyG1 at current scale level
w = 2;
    Region = SpatialSeg(JI2, Region, w);
    % Valley Growing at the next smaller scale level
    Region = ValleyG1(JI1, Region);
    % Valley Growing at the smallest scale level
    Region = ValleyG2(JI1, Region);
    Region2 = Region;
    fprintf('scale2: %d\n', max(Region(:)));
axes(handles.axes9);imshow(uint8(ImgQ));title('区域生长结果3');
hold on;
DrawLine(Region);
hold off;

% % % % % % --------------------scale 1--------------------
w = 1;
    Region = SpatialSeg(JI1, Region, w);
    Region = ValleyG2(JI1, Region);
    Region1 = Region;
    fprintf('scale1: %d\n', max(Region(:))); 
axes(handles.axes10);imshow(uint8(ImgQ));title('区域生长结果4');
hold on;
DrawLine(Region);
hold off;


%Region0 = RegionMerge(image_org,map,  Region, 20);
Region0 = RegionMerge_RGB(image_org,map,  Region, 9);
figure; imshow(uint8(ImgQ));title('区域聚合-最终分割结果');
hold on;
DrawLine(Region0);
hold off;

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
axes(handles.axes1);
imshow([255]);
axes(handles.axes2);
imshow([255]);
axes(handles.axes3);
imshow([255]);
axes(handles.axes4);
imshow([255]);
axes(handles.axes5);
imshow([255]);
axes(handles.axes6);
imshow([255]);
axes(handles.axes7);
imshow([255]);
axes(handles.axes8);
imshow([255]);
axes(handles.axes9);
imshow([255]);
axes(handles.axes10);
imshow([255]);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
