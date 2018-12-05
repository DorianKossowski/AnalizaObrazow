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

% Last Modified by GUIDE v2.5 30-Nov-2018 23:58:12

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
set(handles.uipanel1, 'visible', 'on');
set(handles.uipanel2, 'visible', 'off');

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

global srcImg2_1;
global srcImg2_2;
global dstImg2;
%//////////////////////////////////////////////////////////////////////////
%IMPLEMENTATIONS

% checks if pixel value is in valid range
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
        
        for x=1:size(i,1)
           for y=1:size(i,2)
               newImage(x,y,1) = truncate(R(x,y)+factor);
               newImage(x,y,2) = truncate(G(x,y)+factor);
               newImage(x,y,3) = truncate(B(x,y)+factor);
           end
        end
        
        returnedImage = newImage;
        
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
        
% GRAYSCALE implementation
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
        
% BINARIZE implementation with Otsu's method thresholding
function returnedImage = binarize(image)
    i = toGrayscale(image);
    [counts,binLocations] = imhist(i);
    
    all = sum(counts);
    sumAll = 0.0;
    for p=0:255
        sumAll = sumAll + p*counts(p+1);
    end
    sumB = 0.0;
    weightB = 0.0;
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
        %calculating the individual class variance
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
    
% HISTOGRAM EQUALIZATION implementation
function returnedImage = histEqual(image)
    gIm = toGrayscale(image);
    
    pixelCounter = zeros(1,256);
    [height,width] = size(gIm);

    %Compute the number of occurrences of each gray level
    for i = 1:height
        for j = 1:width
            pixelCounter( gIm(i,j) + 1 ) = pixelCounter( gIm(i,j) + 1 ) + 1;
        end
    end

    %Compute the probability of an occurrence of each gray level
    pixelProb = zeros(1,256);
    for i = 1:256
        pixelProb(i) = pixelCounter(i) / (height * width * 1.0);
    end
    
    %Compute the cumulative distribution function
    pixelCum = zeros(1,256);
    for i = 1:256
        if i == 1
            pixelCum(i) = pixelProb(i);
        else
            pixelCum(i) = pixelCum(i - 1) + pixelProb(i);
        end
    end
    
    %Mapping
    map = zeros(1,256);
    for i = 1:256
        map(i) = uint8(255 * pixelCum(i) + 0.5);
    end
    for i = 1:height
        for j = 1:width
            gIm(i,j) = map(gIm(i,j) + 1);
        end
    end

    returnedImage = gIm;
    
% ROTATION implementation
function returnedImage = rotate(image, degrees)
    img = image;
    [h,w,d] = size(img); 
    rads = deg2rad(degrees);  

    %calculating new image size
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
                  rotatedImg(x,y,:) = img(xx,yy,:);  
             end
        end
    end

    returnedImage = rotatedImg;


% VERTICAL SYMMETRICAL REFLECTION implementation
function returnedImage = verticalSymmetricalReflection(image)
	img = image;
    
    %new image containing all zeros - same size as the originals
	newImage = zeros(size(img,1), size(img,2), 3, 'uint8');

	for x=1:size(img,1)
        for y=1:size(img,2)
            x_new = (size(img,1)+1) - x;
            newImage(x_new,y,:)=img(x,y,:);
        end
    end
    
    returnedImage = newImage;
    
    
% HORIZONTAL SYMMETRICAL REFLECTION implementation
function returnedImage = horizontalSymmetricalReflection(image)
	img = image;
    
    %new image containing all zeros - same size as the originals
	newImage = zeros(size(img,1), size(img,2), 3, 'uint8');

	for x=1:size(img,1)
        for y=1:size(img,2)
            y_new = (size(img,2)+1) - y;
            newImage(x,y_new,:) = img(x,y,:);
        end
    end
    
    returnedImage = newImage;
    
    
% ADD WITH WEIGHTS implementation
function returnedImage = addWithWeights(image1, image2, weight)
    im1=image1;
    im2 = image2;
    [h,w,d]=size(im1);
    im2=imresize(im2, [h,w]);
    
    returnedImage = weight*im1+(1-weight)*im2;
    
    
% MIN OF TWO IMAGES implementation
function returnedImage = minOfTwoImages(image1, image2)
    im1=image1;
    im2 = image2;
    [h,w,d]=size(im1);
    im2=imresize(im2, [h,w]);
    newImage = zeros(h, w, 3, 'uint8');
    for x=1:h
        for y=1:w
            if im1(x,y)<im2(x,y)
                newImage(x,y,:) = im1(x,y,:);
            else
                newImage(x,y,:) = im2(x,y,:);
            end
        end
    end

    returnedImage = newImage;
    
    
% MAX OF TWO IMAGES implementation
function returnedImage = maxOfTwoImages(image1, image2)
    im1=image1;
    im2 = image2;
    [h,w,d]=size(im1);
    im2=imresize(im2, [h,w]);
    newImage = zeros(h, w, 3, 'uint8');
    for x=1:h
        for y=1:w
            if im1(x,y)>im2(x,y)
                newImage(x,y,:) = im1(x,y,:);
            else
                newImage(x,y,:) = im2(x,y,:);
            end
        end
    end

    returnedImage = newImage;

%ADD implementation
function returnImg = add(i1, i2)
    [h,w,d]=size(i1);
    i2=imresize(i2,[h,w]);
    returnImg = (i1+i2)/2;

%SUBSTRACT implementation
function returnImg = substract(i1, i2)
    [h,w,d]=size(i1);
    i2=imresize(i2,[h,w]);
    returnImg = (i1-i2)/2;
    
%MULTIPLY implementation
function returnImg = multiply(i1, i2)
    [h,w,d]=size(i1);
    i2=imresize(i2,[h,w]);
    returnImg = i1.*i2;
    
%DIVIDE implementation
function returnImg = divide(i1, i2)
    [h,w,d]=size(i1);
    i2=imresize(i2,[h,w]);
    returnImg = i1./i2;
%//////////////////////////////////////////////////////////////////////////
      

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)  %LOAD TO FILE
[file, folder] = uigetfile('*.jpg', 'Wybierz obraz do przetowrzenia');
try
    if not(isequal(file,0))
        global srcImg;
        global workingImg;
        srcImg = imread ([folder, file]);
        workingImg = srcImg;
        axes(handles.axes1);
        imshow(workingImg);
        set(handles.popupmenu2, 'enable', 'on');
        set(handles.popupmenu2, 'value', 1);
        
        set(handles.edit1, 'enable', 'on');
        set(handles.edit1, 'string', 0);
        
        set(handles.checkbox4, 'enable', 'on');
        set(handles.checkbox4, 'value', 0);
        set(handles.checkbox5, 'enable', 'on');
        set(handles.checkbox5, 'value', 0);
        set(handles.pushbutton3, 'enable', 'on');
        slidersVisible(handles, 'off');
    end
catch
    uiwait(errordlg('Nie mozna odczytac pliku', 'Problem'));
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)  %SAVE TO FILE
[file, folder] = uiputfile('.jpg');
try
    if not(isequal(file,0))
        global workingImg; 
        imwrite(workingImg, fullfile(folder, file));
        uiwait(msgbox(strcat('Poprawnie zapisano: ', fullfile(folder, file)), 'Sukces'));
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

function slidersVisible(handles, flag)
    set(handles.slider1,'visible',flag)
    set(handles.slider2,'visible',flag)
    set(handles.slider3,'visible',flag)
    set(handles.text2,'visible',flag)
    set(handles.text3,'visible',flag)
    set(handles.text4,'visible',flag)  
    
% --- Executes on selection change in popupmenu2.           %POPUPMENU
function popupmenu2_Callback(hObject, eventdata, handles)
global srcImg;
global workingImg;
content = get(hObject, 'Value');
switch content
    case 1  %default
        axes(handles.axes1);
        imshow(srcImg);
        slidersVisible(handles, 'off');
    case 2  %sliders
        axes(handles.axes1);
        imshow(srcImg);
        slidersVisible(handles, 'on');
    case 3  %grayscale
        slidersVisible(handles, 'off');
        workingImg = toGrayscale(srcImg);
        axes(handles.axes1);
        imshow(workingImg);
    case 4  %binarize
        slidersVisible(handles, 'off');
        workingImg = binarize(srcImg);
        axes(handles.axes1);
        imshow(workingImg);
    case 5 %histogram equalization
        slidersVisible(handles, 'off');
        workingImg = histEqual(srcImg);
        axes(handles.axes1);
        imshow(workingImg);
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global srcImg;
global workingImg;
if get(hObject,'String')
    angle = str2double(get(hObject,'String'));
    workingImg = rotate(workingImg, angle);
    axes(handles.axes1);
    imshow(workingImg);
else
    axes(handles.axes1);
    imshow(workingImg);
end


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
global srcImg;
global workingImg;
if get(hObject,'Value')
    workingImg = horizontalSymmetricalReflection(workingImg);
    axes(handles.axes1);
    imshow(workingImg);
else
    axes(handles.axes1);
    imshow(workingImg);
end

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
global srcImg;
global workingImg;
if get(hObject,'Value')
    workingImg = verticalSymmetricalReflection(workingImg);
    axes(handles.axes1);
    imshow(workingImg);
else
    axes(handles.axes1);
    imshow(workingImg);
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off');
set(handles.uipanel2, 'visible', 'on');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles) %LOAD 1st
[file, folder] = uigetfile('*.jpg', 'Wybierz obraz do przetowrzenia');
try
    if not(isequal(file,0))
        
        global srcImg2_1;
        srcImg2_1 = imread ([folder, file]);
        axes(handles.axes2);
        imshow(srcImg2_1);
        
        axes(handles.axes4);
        imshow([]); 
        set(handles.popupmenu4, 'value', 1);
        disableEdits(handles);
        set(handles.pushbutton7, 'enable', 'off');
        set(handles.pushbutton10, 'enable', 'on');
    end
catch
    uiwait(errordlg('Nie mozna odczytac pliku', 'Problem'));
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)  %SAVE FILE
[file, folder] = uiputfile('.jpg');
try
    if not(isequal(file,0))
        global dstImg2; 
        imwrite(dstImg2, fullfile(folder, file));
        uiwait(msgbox(strcat('Poprawnie zapisano: ', fullfile(folder, file)), 'Sukces'));
    end
catch
    uiwait(errordlg('Nie mozna zapisac do pliku', 'Problem'));
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'on');
set(handles.uipanel2, 'visible', 'off');

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles) %LOAD 2nd
[file, folder] = uigetfile('*.jpg', 'Wybierz obraz do przetowrzenia');
try
    if not(isequal(file,0))
        global srcImg2_2;
        srcImg2_2 = imread ([folder, file]);
        axes(handles.axes3);
        imshow(srcImg2_2);
        set(handles.popupmenu4, 'enable', 'on');
        
        axes(handles.axes4);
        imshow([]); 
        set(handles.popupmenu4, 'value', 1);
        disableEdits(handles);
        set(handles.pushbutton7, 'enable', 'off');
    end
catch
    uiwait(errordlg('Nie mozna odczytac pliku', 'Problem'));
end

function disableEdits(handles)
    set(handles.edit3, 'enable', 'off');
    set(handles.edit4, 'enable', 'off');
    set(handles.edit3, 'string', 1);
    set(handles.edit3, 'value', 1);
    set(handles.edit4, 'string', 1);
    set(handles.edit4, 'value', 1);

% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)   %POPUPMENU
global srcImg2_1;
global srcImg2_2;
global dstImg2;
content = get(hObject, 'Value');

if content==3
    set(handles.edit3, 'enable', 'on');
else
    disableEdits(handles);
end

if content==1
    set(handles.pushbutton7, 'enable', 'off');
else
    set(handles.pushbutton7, 'enable', 'on');
end

switch content
    case 2  %add
        dstImg2 = add(srcImg2_1, srcImg2_2);
        axes(handles.axes4);
        imshow(dstImg2);
        set(handles.axes4, 'visible', 'on');
        axis off;
    case 3  %add with importance
        set(handles.axes4, 'visible', 'on');
        axis off;
    case 4  %substract
        dstImg2 = substract(srcImg2_1, srcImg2_2);
        axes(handles.axes4);
        imshow(dstImg2);
        set(handles.axes4, 'visible', 'on');
        axis off;
    case 5 %multiply
        dstImg2 = multiply(srcImg2_1, srcImg2_2);
        axes(handles.axes4);
        imshow(dstImg2);
        set(handles.axes4, 'visible', 'on');
        axis off;
    case 6 %divide
        dstImg2 = divide(srcImg2_1, srcImg2_2);
        axes(handles.axes4);
        imshow(dstImg2);
        set(handles.axes4, 'visible', 'on');
        axis off;
    case 7 %MIN
        dstImg2 = minOfTwoImages(srcImg2_1, srcImg2_2);
        axes(handles.axes4);
        imshow(dstImg2);
        set(handles.axes4, 'visible', 'on');
        axis off;
    case 8 %MAX
        dstImg2 = maxOfTwoImages(srcImg2_1, srcImg2_2);
        axes(handles.axes4);
        imshow(dstImg2);
        set(handles.axes4, 'visible', 'on');
        axis off;
end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global srcImg2_1;
global srcImg2_2;
global dstImg2;
if get(hObject,'String')
    w1 = str2double(get(hObject,'String'));
    if w1>=0 && w1<=1
        set(handles.edit4, 'string', num2str(1.0-w1));
        dstImg2 = addWithWeights(srcImg2_1, srcImg2_2, w1);
        axes(handles.axes4);
        imshow(dstImg2);
    else
        uiwait(errordlg('Waga musi byæ z przedzia³u [0, 1]', 'Problem'));
    end
else
    set(handles.edit4, 'string', '1');
    axes(handles.axes4);
    imshow(srcImg2_2);
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
