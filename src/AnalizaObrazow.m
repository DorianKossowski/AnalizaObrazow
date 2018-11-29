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

% check if pixel value is in valid range
function returnedValue = truncate(value)
    if(value<0)
        value=0;
    end
    if(value>255)
        value=255;
    end
    returnedValue = value;

% BRIGHTNESS implementation
function returnedImage = brightness(image, factor)
        i = image;
        %separate the image into three different 2d matrices of R, G, B
        R = double(i(:, :, 1));
        G = double(i(:, :, 2));
        B = double(i(:, :, 3));
        %new image containing all zeros - same size as the original
        newImage = zeros(size(i,1), size(i,2), 3, 'uint8');
        
        %
        for x=1:size(i,1)
           for y=1:size(i,2)
               newImage(x,y,1) = truncate(R(x,y)+factor);
               newImage(x,y,2) = truncate(G(x,y)+factor);
               newImage(x,y,3) = truncate(B(x,y)+factor);
           end
        end
        
        returnedImage = newImage;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global srcImg;
global workingImg;
if get(hObject,'Value')
    workingImg = brightness(srcImg, get(hObject,'Value'));
    axes(handles.axes1);
    imshow(workingImg);
else
    axes(handles.axes1);
    imshow(srcImg);
end


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Min', -255, 'Max', 255);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% CONTRAST implementation
function returnedImage = contrast(image, factor)
        i = image;
        %separate the image into three different 2d matrices of R, G, B
        R = double(i(:, :, 1));
        G = double(i(:, :, 2));
        B = double(i(:, :, 3));
        %new image containing all zeros - same size as the original
        newImage = zeros(size(i,1), size(i,2), 3, 'uint8');
        
        %
        for x=1:size(i,1)
           for y=1:size(i,2)
               newImage(x,y,1) = truncate(factor*(R(x,y)-128)+128);
               newImage(x,y,2) = truncate(factor*(G(x,y)-128)+128);
               newImage(x,y,3) = truncate(factor*(B(x,y)-128)+128);
           end
        end
        
        returnedImage = newImage;


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global srcImg;
global workingImg;
if get(hObject,'Value')
    c = get(hObject,'Value');
    factor = 259*(c + 255) / (255*(259-c));
    workingImg = contrast(srcImg, factor);
    axes(handles.axes1);
    imshow(workingImg);
else
    axes(handles.axes1);
    imshow(srcImg);
end

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Min', -255, 'Max', 255);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% GAMMA CORRECTION implementation
function returnedImage = gamma(image, g)
        i = image;
        %separate the image into three different 2d matrices of R, G, B
        R = double(i(:, :, 1));
        G = double(i(:, :, 2));
        B = double(i(:, :, 3));
        %new image containing all zeros - same size as the original
        newImage = zeros(size(i,1), size(i,2), 3, 'uint8');
        
        for x=1:size(i,1)
           for y=1:size(i,2)
               newImage(x,y,1) = 255*(R(x,y)/255)^g;
               newImage(x,y,2) = 255*(G(x,y)/255)^g;
               newImage(x,y,3) = 255*(B(x,y)/255)^g;
           end
        end
        
        returnedImage = newImage;


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global srcImg;
global workingImg;
if get(hObject,'Value')
    g = 1/get(hObject,'Value');
    workingImg = gamma(srcImg, g);
    axes(handles.axes1);
    imshow(workingImg);
else
    axes(handles.axes1);
    imshow(srcImg);
end

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Min', 0.01, 'Max', 3.99);
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


% BINARIZE implementation with Otsu's method thresholding
function returnedImage = binarize(image)
    i=toGrayscale(image);
    [counts,binLocations] = imhist(i);
    
    all = sum(counts);
    sumAll = 0.0;
    for p=0:255
        sumAll = sumAll + p*counts(p+1);
    end
    sumB = 0.0;
    weightB = 0.0;
    weightF = 0.0;
    max = 0.0;
    t=0;
    for p=0:255
        weightB = weightB + counts(p+1);
        if(weightB == 0)
            continue;
        end
        weightF = all - weightB;
        if(weightF==0)
            continue;
        end
        sumB = sumB + p*counts(p+1);
        meanB = sumB/weightB;
        meanF = (sumAll-sumB)/weightF;
        %Calculate the individual class variance
        between = weightB * weightF * (meanB - meanF)^2;
        if(between > max)
            max = between;
            t=p;
        end
    end
    
    newImage = zeros(size(i,1), size(i,2), 'uint8');
        
    for x=1:size(i,1)
        for y=1:size(i,2)
        	if i(x,y)>t
            	newImage(x,y) = 255;
            end
        end
    end
    
    returnedImage = newImage;
    

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global srcImg;
global workingImg;
if get(hObject,'Value')
    workingImg = binarize(srcImg);
    axes(handles.axes1);
    imshow(workingImg);
else
    axes(handles.axes1);
    imshow(srcImg);
end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3

%ROTATION implementation
function returnedImage = rotate(image, degrees)
    img = image;
    [h,w,z] = size(img); 
    rads = deg2rad(degrees);  

    % calculating array dimesions such that  rotated image gets fit in it exactly
    new_h = ceil(h*abs(cos(rads))+w*abs(sin(rads)));                      
    new_w = ceil(h*abs(sin(rads))+w*abs(cos(rads)));                     

    %new image containing all zeros - calculated size
    rotatedImg = zeros(new_h, new_w, 3, 'uint8');

    %calculating center of original and rotated image
    x0 = ceil(h/2);                                                            
    y0 = ceil(w/2);
    new_x0 = ceil((size(rotatedImg,1))/2);
    new_y0 = ceil((size(rotatedImg,2))/2);

    for x=1:size(rotatedImg,1)
        for y=1:size(rotatedImg,2)                                                       
             xx = (x-new_x0)*cos(rads)+(y-new_y0)*sin(rads);                                       
             yy = -(x-new_x0)*sin(rads)+(y-new_y0)*cos(rads);                             
             xx = round(xx)+x0;
             yy = round(yy)+y0;
             if (xx>=1 && yy>=1 && xx<=size(img,1) &&  yy<=size(img,2) ) 
                  rotatedImg(x,y,:)=img(xx,yy,:);  
             end
        end
    end

    returnedImage=rotatedImg;


%VERTICAL SYMMETRICAL REFLECTION implementation
function returnedImage = verticalSymmetricalReflection(image)
	img = image;
    
    %new image containing all zeros - same size as the originals
	newImage=zeros(size(img,1), size(img,2), 3, 'uint8');

	for x=1:size(img,1)
        for y=1:size(img,2)
            x_new = (size(img,1)+1) - x;
            newImage(x_new,y,:)=img(x,y,:);
        end
    end
    
    returnedImage=newImage;
    
    
%HORIZONTAL SYMMETRICAL REFLECTION implementation
function returnedImage = horizontalSymmetricalReflection(image)
	img = image;
    
    %new image containing all zeros - same size as the originals
	newImage=zeros(size(img,1), size(img,2), 3, 'uint8');

	for x=1:size(img,1)
        for y=1:size(img,2)
            y_new = (size(img,2)+1) - y;
            newImage(x,y_new,:)=img(x,y,:);
        end
    end
    
    returnedImage=newImage;