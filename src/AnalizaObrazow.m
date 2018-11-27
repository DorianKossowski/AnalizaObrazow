function varargout = AnalizaObrazow(varargin)
% ANALIZAOBRAZOW MATLAB code for AnalizaObrazow.fig
%      ANALIZAOBRAZOW, by itself, creates a new ANALIZAOBRAZOW or raises the existing
%      singleton*.
%
%      H = ANALIZAOBRAZOW returns the handle to a new ANALIZAOBRAZOW or the handle to
%      the existing singleton*.
%
%      ANALIZAOBRAZOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALIZAOBRAZOW.M with the given input arguments.
%
%      ANALIZAOBRAZOW('Property','Value',...) creates a new ANALIZAOBRAZOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalizaObrazow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalizaObrazow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalizaObrazow

% Last Modified by GUIDE v2.5 27-Nov-2018 22:43:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalizaObrazow_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalizaObrazow_OutputFcn, ...
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


% --- Executes just before AnalizaObrazow is made visible.
function AnalizaObrazow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalizaObrazow (see VARARGIN)

% Choose default command line output for AnalizaObrazow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalizaObrazow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AnalizaObrazow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%//////////////////////////////////////////////////////////////////////////
%GLOBAL VARS
global srcImg;
global workingImg;
%//////////////////////////////////////////////////////////////////////////

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)  %LOAD TO FILE
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, folder] = uigetfile('*.jpg', 'Wybierz obraz do przetowrzenia');
try
    if not(isequal(file,0))
        global srcImg;
        srcImg = imread ([folder, file]);
        axes(handles.axes1);
        imshow(srcImg);
    end
catch
    uiwait(errordlg('Nie mozna odczytac pliku', 'Problem'));
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)  %SAVE TO FILE
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, folder] = uiputfile('.jpg');
try
    if not(isequal(file,0))
        global srcImg;
        
        %grayscale checkbox
        if get(handles.checkbox1, 'Value')
            srcImg = toGrayscale(srcImg);
        end
        
        imwrite(srcImg, fullfile(folder, file));
    end
catch
    uiwait(errordlg('Nie mozna zapisac do pliku', 'Problem'));
end 


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%GRAYSCALE implementation
function returnedImage = toGrayscale(image)
        i = image;
        %separate the image into three different 2d matrices of R, G, B
        R = i(:, :, 1);
        G = i(:, :, 2);
        B = i(:, :, 3);
        %new image containing all zeros - same size as the original
        newImage = zeros(size(i,1), size(i,2), 'uint8');
        
        %luminosity method
        for x=1:size(i,1)
           for y=1:size(i,2)
               newImage(x,y) = (R(x,y)*.21)+(G(x,y)*.72)+(B(x,y)*.07);
           end
        end
        
        returnedImage = newImage;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)    %GRAYSCALE
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox1

global srcImg;
global workingImg;
if get(hObject,'Value')
    workingImg = toGrayscale(srcImg);
    axes(handles.axes1);
    imshow(workingImg);
else
    axes(handles.axes1);
    imshow(srcImg);
end

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
