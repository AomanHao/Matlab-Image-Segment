function varargout = app(varargin)
% APP M-file for app.fig
%      APP, by itself, creates a new APP or raises the existing
%      singleton*.
%
%      H = APP returns the handle to a new APP or the handle to
%      the existing singleton*.
%
%      APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APP.M with the given input arguments.
%
%      APP('Property','Value',...) creates a new APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before app_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to app_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help app

% Last Modified by GUIDE v2.5 17-Feb-2009 13:58:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @app_OpeningFcn, ...
                   'gui_OutputFcn',  @app_OutputFcn, ...
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


% --- Executes just before app is made visible.
function app_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to app (see VARARGIN)

% Choose default command line output for app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes app wait for user response (see UIRESUME)
% uiwait(handles.figure1);

init(handles);

% --- Outputs from this function are returned to the command line.
function varargout = app_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Initialization function
function init(handles)

global appdata;
appdata.simg=[];
appdata.timg=[];
appdata.trimap=[];
appdata.matte=[];
appdata.result=[];

% clear axes
imshow([],'Parent',handles.source_axes);
imshow([],'Parent',handles.trimap_axes);
imshow([],'Parent',handles.alpha_axes);
drawnow;

% --------------------------------------------------------------------
function menu_load_source_image_Callback(hObject, eventdata, handles)
% hObject    handle to menu_load_source_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;
[filename,cancelled]=imgetfile;
if ~cancelled
    init(handles);
    appdata.simg=imread(filename);
    imshow(appdata.simg,'Parent',handles.source_axes);
end


% --------------------------------------------------------------------
function menu_file_enter_trimap_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file__enter_trimap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;
if isempty(appdata.simg)
    warndlg('Load source image first!');
    return;
end
appdata.trimap=getTrimap(appdata.simg);
close; % close trimap window
imshow(appdata.trimap,'Parent',handles.trimap_axes);


% --------------------------------------------------------------------
function menu_file_save_trimap_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_save_trimap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;
if isempty(appdata.trimap)
    warndlg('Trimap not entered!');
    return;
end
[filename,pathname] = uiputfile('*.png'); 
if filename
    imwrite(appdata.trimap,[pathname filename]);
end


% --------------------------------------------------------------------
function menu_file_load_trimap_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_load_trimap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;
if isempty(appdata.simg)
    warndlg('Load source image first!');
    return;
end
[filename,cancelled]=imgetfile;
if ~cancelled
    appdata.trimap=imread(filename);
    imshow(appdata.trimap,'Parent',handles.trimap_axes);
end


% --------------------------------------------------------------------
function menu_file_load_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_load_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;

% will override currently loaded data
[filename,pathname] = uigetfile('*.mat');
if filename
    matte=load([pathname filename]);
    init(handles);
    % reconstruct source image
    simg=repmat(matte.alpha,[1,1,3]).*matte.F+repmat(1-matte.alpha,[1,1,3]).*matte.B;
    appdata.simg=simg;
    appdata.trimap=matte.trimap;
    appdata.matte.F=matte.F;
    appdata.matte.B=matte.B;
    appdata.matte.alpha=matte.alpha;
    imshow(appdata.simg,'Parent',handles.source_axes);
    imshow(appdata.trimap,'Parent',handles.trimap_axes);
    imshow(appdata.matte.alpha,'Parent',handles.alpha_axes);
end


% --------------------------------------------------------------------
function menu_compose_create_composite_Callback(hObject, eventdata, handles)
% hObject    handle to menu_compose_create_composite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;
if isempty(appdata.matte)
    warndlg('Calculate/Load matte first!');
    return;
end
% get target image
[filename,cancelled]=imgetfile;
if ~cancelled
    appdata.timg=imread(filename);
    appdata.result=makeComposite(appdata.matte.F,appdata.timg,appdata.matte.alpha);
    figure('Name','New Composite','NumberTitle','off');
    imshow(appdata.result);
end



% --------------------------------------------------------------------
function menu_run_calc_alpha_matte_Callback(hObject, eventdata, handles)
% hObject    handle to menu_run_calc_alpha_matte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;

if isempty(appdata.trimap)
    warndlg('Enter/Load trimap first!');
    return;
end
p=makeParameters;
p.guiMode=1;
[F,B,alpha]=bayesmat(appdata.simg,appdata.trimap,p);
appdata.matte.F=F;
appdata.matte.B=B;
appdata.matte.alpha=alpha;
appdata.matte.trimap=appdata.trimap;
imshow(appdata.matte.alpha,'Parent',handles.alpha_axes);

% shop alpha in separate window
figure('Name','Alpha Result','NumberTitle','off');
imshow(alpha);

% --------------------------------------------------------------------
function menu_compose_save_composite_Callback(hObject, eventdata, handles)
% hObject    handle to menu_compose_save_composite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;

if isempty(appdata.result)
    warndlg('Create Composite first!');
    return;
end
[filename,pathname] = uiputfile('*.png;*.jpg'); 
if filename
    imwrite(appdata.result,[pathname filename]);
end


% --------------------------------------------------------------------
function menu_run_save_alpha_matte_Callback(hObject, eventdata, handles)
% hObject    handle to menu_run_save_alpha_matte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global appdata;

if isempty(appdata.matte)
    warndlg('Calculate alpha matte first!');
    return;
end
[filename,pathname] = uiputfile('*.mat');
if filename
    F=appdata.matte.F;
    B=appdata.matte.B;
    alpha=appdata.matte.alpha;
    trimap=appdata.trimap;
    save([pathname filename],'F','B','alpha','trimap');
end


