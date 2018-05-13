function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 25-Dec-2017 04:28:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtOpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to txtOpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtOpenImage as text
%        str2double(get(hObject,'String')) returns contents of txtOpenImage as a double


% --- Executes during object creation, after setting all properties.
function txtOpenImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtOpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnOpenImage.
function btnOpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImageName = get(handles.txtOpenImage, 'string');
Img = imread(char(ImageName));
% Set current drawing axes to "axes1"

Img=imresize(Img,[700 700]);
handles.Image = Img ;
axes(handles.axes1);
% Display the image
imshow(handles.Image);
% Save the handles structure.
guidata(hObject, handles);

% --- Executes on button press in btnIdentify.
function btnIdentify_Callback(hObject, eventdata, handles)
% hObject    handle to btnIdentify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Generic = get(handles.bxGeneric, 'Value');
Color = get(handles.bxDetectColor, 'Value');
Size = get(handles.bxRecognizeSize, 'Value');
Price = get(handles.bxRecognizePrice, 'Value');
[vendor strings] = detectDigits(handles.Image , Generic , Color , Size , Price);
result = '';
if(vendor== 1) result = 'biege';
    elseif(vendor ==2) result = 'black';
        elseif(vendor ==3) result = 'brown';
    elseif(vendor ==4) result = 'dack blue';
elseif(vendor ==5) result = 'light blue';
end
[a b] = size(strings);
MainStr = zeros(1,0);
for i=1 : a
    str = zeros(1,0);
    for j=1 : b
        if(strings(i,j) == -2)
            break;
        end
        if(strings(i,j) == 10)
           str = [str '$'] ;
        elseif(strings(i,j) == -1)
            str = [str '.'] ;
            if(str(1,1) ~= '$')
                str = ['$' str];
            end
        else
            str = [ str num2str(strings(i,j))];
        end
    end
    [x  y] = size(str);
    if((y>2 || Price)&& str(1,1) ~= '$')
        str = ['$' str];
    end
    MainStr = [MainStr str '\n'];
end
MainStr = [MainStr result];
MainStr = compose(MainStr)
NewStr = splitlines(MainStr);
set(handles.listbox1, 'str', NewStr);
% Set current drawing axes to "axes2"
axes(handles.axes3); % Make axes1 the gca.
imshow(vendor);

% Save the handles structure.
guidata(hObject, handles);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bxGeneric.
function bxGeneric_Callback(hObject, eventdata, handles)
% hObject    handle to bxGeneric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bxGeneric


% --- Executes on button press in bxDetectColor.
function bxDetectColor_Callback(hObject, eventdata, handles)
% hObject    handle to bxDetectColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bxDetectColor


% --- Executes on button press in bxRecognizeSize.
function bxRecognizeSize_Callback(hObject, eventdata, handles)
% hObject    handle to bxRecognizeSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bxRecognizeSize


% --- Executes on button press in bxRecognizePrice.
function bxRecognizePrice_Callback(hObject, eventdata, handles)
% hObject    handle to bxRecognizePrice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bxRecognizePrice
