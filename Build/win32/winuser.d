module win32.winuser;
import win32.wingdi;
import win32.windef;
import win32.winnt;
import win32.basetsd;

extern(System):

enum {
	VK_LBUTTON = 0x01,
	VK_RBUTTON = 0x02,
	VK_CANCEL = 0x03,
	VK_MBUTTON = 0x04,
	//static if (_WIN32_WINNT > =  0x500) {
	VK_XBUTTON1 = 0x05,
	VK_XBUTTON2 = 0x06,
	//}
	VK_BACK = 0x08,
	VK_TAB = 0x09,
	VK_CLEAR = 0x0C,
	VK_RETURN = 0x0D,
	VK_SHIFT = 0x10,
	VK_CONTROL = 0x11,
	VK_MENU = 0x12,
	VK_PAUSE = 0x13,
	VK_CAPITAL = 0x14,
	VK_KANA = 0x15,
	VK_HANGEUL = 0x15,
	VK_HANGUL = 0x15,
	VK_JUNJA = 0x17,
	VK_FINAL = 0x18,
	VK_HANJA = 0x19,
	VK_KANJI = 0x19,
	VK_ESCAPE = 0x1B,
	VK_CONVERT = 0x1C,
	VK_NONCONVERT = 0x1D,
	VK_ACCEPT = 0x1E,
	VK_MODECHANGE = 0x1F,
	VK_SPACE = 0x20,
	VK_PRIOR = 0x21,
	VK_NEXT = 0x22,
	VK_END = 0x23,
	VK_HOME = 0x24,
	VK_LEFT = 0x25,
	VK_UP = 0x26,
	VK_RIGHT = 0x27,
	VK_DOWN = 0x28,
	VK_SELECT = 0x29,
	VK_PRINT = 0x2A,
	VK_EXECUTE = 0x2B,
	VK_SNAPSHOT = 0x2C,
	VK_INSERT = 0x2D,
	VK_DELETE = 0x2E,
	VK_HELP = 0x2F,
	VK_LWIN = 0x5B,
	VK_RWIN = 0x5C,
	VK_APPS = 0x5D,
	VK_SLEEP = 0x5F,
	VK_NUMPAD0 = 0x60,
	VK_NUMPAD1 = 0x61,
	VK_NUMPAD2 = 0x62,
	VK_NUMPAD3 = 0x63,
	VK_NUMPAD4 = 0x64,
	VK_NUMPAD5 = 0x65,
	VK_NUMPAD6 = 0x66,
	VK_NUMPAD7 = 0x67,
	VK_NUMPAD8 = 0x68,
	VK_NUMPAD9 = 0x69,
	VK_MULTIPLY = 0x6A,
	VK_ADD = 0x6B,
	VK_SEPARATOR = 0x6C,
	VK_SUBTRACT = 0x6D,
	VK_DECIMAL = 0x6E,
	VK_DIVIDE = 0x6F,
	VK_F1 = 0x70,
	VK_F2 = 0x71,
	VK_F3 = 0x72,
	VK_F4 = 0x73,
	VK_F5 = 0x74,
	VK_F6 = 0x75,
	VK_F7 = 0x76,
	VK_F8 = 0x77,
	VK_F9 = 0x78,
	VK_F10 = 0x79,
	VK_F11 = 0x7A,
	VK_F12 = 0x7B,
	VK_F13 = 0x7C,
	VK_F14 = 0x7D,
	VK_F15 = 0x7E,
	VK_F16 = 0x7F,
	VK_F17 = 0x80,
	VK_F18 = 0x81,
	VK_F19 = 0x82,
	VK_F20 = 0x83,
	VK_F21 = 0x84,
	VK_F22 = 0x85,
	VK_F23 = 0x86,
	VK_F24 = 0x87,
	VK_NUMLOCK = 0x90,
	VK_SCROLL = 0x91,
	VK_LSHIFT = 0xA0,
	VK_RSHIFT = 0xA1,
	VK_LCONTROL = 0xA2,
	VK_RCONTROL = 0xA3,
	VK_LMENU = 0xA4,
	VK_RMENU = 0xA5,
	//static if (_WIN32_WINNT > =  0x500) {
	VK_BROWSER_BACK = 0xA6,
	VK_BROWSER_FORWARD = 0xA7,
	VK_BROWSER_REFRESH = 0xA8,
	VK_BROWSER_STOP = 0xA9,
	VK_BROWSER_SEARCH = 0xAA,
	VK_BROWSER_FAVORITES = 0xAB,
	VK_BROWSER_HOME = 0xAC,
	VK_VOLUME_MUTE = 0xAD,
	VK_VOLUME_DOWN = 0xAE,
	VK_VOLUME_UP = 0xAF,
	VK_MEDIA_NEXT_TRACK = 0xB0,
	VK_MEDIA_PREV_TRACK = 0xB1,
	VK_MEDIA_STOP = 0xB2,
	VK_MEDIA_PLAY_PAUSE = 0xB3,
	VK_LAUNCH_MAIL = 0xB4,
	VK_LAUNCH_MEDIA_SELECT = 0xB5,
	VK_LAUNCH_APP1 = 0xB6,
	VK_LAUNCH_APP2 = 0xB7,
	//}
	VK_OEM_1 = 0xBA,
	//static if (_WIN32_WINNT > =  0x500) {
	VK_OEM_PLUS = 0xBB,
	VK_OEM_COMMA = 0xBC,
	VK_OEM_MINUS = 0xBD,
	VK_OEM_PERIOD = 0xBE,
	//}
	VK_OEM_2 = 0xBF,
	VK_OEM_3 = 0xC0,
	VK_OEM_4 = 0xDB,
	VK_OEM_5 = 0xDC,
	VK_OEM_6 = 0xDD,
	VK_OEM_7 = 0xDE,
	VK_OEM_8 = 0xDF,
	//static if (_WIN32_WINNT > =  0x500) {
	VK_OEM_102 = 0xE2,
	//}
	VK_PROCESSKEY = 0xE5,
	//static if (_WIN32_WINNT > =  0x500) {
	VK_PACKET = 0xE7,
	//}
	VK_ATTN = 0xF6,
	VK_CRSEL = 0xF7,
	VK_EXSEL = 0xF8,
	VK_EREOF = 0xF9,
	VK_PLAY = 0xFA,
	VK_ZOOM = 0xFB,
	VK_NONAME = 0xFC,
	VK_PA1 = 0xFD,
	VK_OEM_CLEAR = 0xFE,
}

enum {
	WS_OVERLAPPED       = 0,
	WS_TILED            = WS_OVERLAPPED,
	WS_MAXIMIZEBOX      = 0x00010000,
	WS_MINIMIZEBOX      = 0x00020000,
	WS_TABSTOP          = 0x00010000,
	WS_GROUP            = 0x00020000,
	WS_THICKFRAME       = 0x00040000,
	WS_SIZEBOX          = WS_THICKFRAME,
	WS_SYSMENU          = 0x00080000,
	WS_HSCROLL          = 0x00100000,
	WS_VSCROLL          = 0x00200000,
	WS_DLGFRAME         = 0x00400000,
	WS_BORDER           = 0x00800000,
	WS_CAPTION          = 0x00c00000,
	WS_OVERLAPPEDWINDOW = WS_OVERLAPPED|WS_CAPTION|WS_SYSMENU|WS_THICKFRAME|WS_MINIMIZEBOX|WS_MAXIMIZEBOX,
	WS_TILEDWINDOW      = WS_OVERLAPPEDWINDOW,
	WS_MAXIMIZE         = 0x01000000,
	WS_CLIPCHILDREN     = 0x02000000,
	WS_CLIPSIBLINGS     = 0x04000000,
	WS_DISABLED         = 0x08000000,
	WS_VISIBLE          = 0x10000000,
	WS_MINIMIZE         = 0x20000000,
	WS_ICONIC           = WS_MINIMIZE,
	WS_CHILD            = 0x40000000,
	WS_CHILDWINDOW      = 0x40000000,
	WS_POPUP            = 0x80000000,
	WS_POPUPWINDOW      = WS_POPUP|WS_BORDER|WS_SYSMENU,
}

HWND CreateWindowA(LPCSTR a, LPCSTR b, DWORD c, int d, int e, int f, int g, HWND h, HMENU i, HINSTANCE j, LPVOID k)
{
	return CreateWindowExA(0, a, b, c, d, e, f, g, h, i, j, k);
}

HWND CreateWindowW(LPCWSTR a, LPCWSTR b, DWORD c, int d, int e, int f, int g, HWND h, HMENU i, HINSTANCE j, LPVOID k)
{
	return CreateWindowExW(0, a, b, c, d, e, f, g, h, i, j, k);
}

alias CreateWindowA CreateWindow;
alias CreateWindowExA CreateWindowEx;

const IDOK       = 1;
const IDCANCEL   = 2;
const IDABORT    = 3;
const IDRETRY    = 4;
const IDIGNORE   = 5;
const IDYES      = 6;
const IDNO       = 7;

const GWL_EXSTYLE = -20;
const GWL_STYLE = -16;
const GWL_WNDPROC = -4;
const GWLP_WNDPROC = -4;
const GWL_HINSTANCE = -6;
const GWLP_HINSTANCE = -6;
const GWL_HWNDPARENT = -8;
const GWLP_HWNDPARENT = -8;
const GWL_ID = -12;
const GWLP_ID = -12;
const GWL_USERDATA = -21;
const GWLP_USERDATA = -21;

const DWL_DLGPROC = 4;
const DWLP_DLGPROC = 4;
const DWL_MSGRESULT = 0;
const DWLP_MSGRESULT = 0;
const DWL_USER = 8;
const DWLP_USER = 8;

const WM_MENUCHAR=288;
const WM_MENUSELECT=287;
const WM_MOVE=3;
const WM_MOVING=534;
const WM_NCACTIVATE=134;
const WM_NCCALCSIZE=131;
const WM_NCCREATE=129;
const WM_NCDESTROY=130;
const WM_NCHITTEST=132;
const WM_NCLBUTTONDBLCLK=163;
const WM_NCLBUTTONDOWN=161;
const WM_NCLBUTTONUP=162;
const WM_NCMBUTTONDBLCLK=169;
const WM_NCMBUTTONDOWN=167;
const WM_NCMBUTTONUP=168;

const WM_NCMOUSEMOVE=160;
const WM_NCPAINT=133;
const WM_NCRBUTTONDBLCLK=166;
const WM_NCRBUTTONDOWN=164;
const WM_NCRBUTTONUP=165;
const WM_NEXTDLGCTL=40;
const WM_NEXTMENU=531;
const WM_NOTIFY=78;
const WM_NOTIFYFORMAT=85;
const WM_NULL=0;
const WM_PAINT=15;
const WM_PAINTCLIPBOARD=777;
const WM_PAINTICON=38;
const WM_PALETTECHANGED=785;
const WM_PALETTEISCHANGING=784;
const WM_PARENTNOTIFY=528;
const WM_PASTE=770;
const WM_PENWINFIRST=896;
const WM_PENWINLAST=911;
const WM_POWER=72;
const WM_POWERBROADCAST=536;
const WM_PRINT=791;
const WM_PRINTCLIENT=792;
const WM_APPCOMMAND = 0x0319;
const WM_QUERYDRAGICON=55;
const WM_QUERYENDSESSION=17;
const WM_QUERYNEWPALETTE=783;
const WM_QUERYOPEN=19;
const WM_QUEUESYNC=35;
const WM_QUIT=18;
const WM_RENDERALLFORMATS=774;
const WM_RENDERFORMAT=773;
const WM_SETCURSOR=32;
const WM_SETFOCUS=7;
const WM_SETFONT=48;
const WM_SETHOTKEY=50;
const WM_SETICON=128;
const WM_SETREDRAW=11;
const WM_SETTEXT=12;
const WM_SETTINGCHANGE=26;
const WM_SHOWWINDOW=24;
const WM_SIZE=5;
const WM_SIZECLIPBOARD=779;
const WM_SIZING=532;
const WM_SPOOLERSTATUS=42;
const WM_STYLECHANGED=125;
const WM_STYLECHANGING=124;
const WM_SYSCHAR=262;
const WM_SYSCOLORCHANGE=21;
const WM_SYSCOMMAND=274;
const WM_SYSDEADCHAR=263;
const WM_SYSKEYDOWN=260;
const WM_SYSKEYUP=261;
const WM_TCARD=82;
const WM_THEMECHANGED=794;
const WM_TIMECHANGE=30;
const WM_TIMER=275;
const WM_UNDO=772;
const WM_USER=1024;
const WM_USERCHANGED=84;
const WM_VKEYTOITEM=46;
const WM_VSCROLL=277;
const WM_VSCROLLCLIPBOARD=778;
const WM_WINDOWPOSCHANGED=71;
const WM_WINDOWPOSCHANGING=70;
const WM_WININICHANGE=26;
const WM_INPUT=255;
const WM_KEYFIRST=256;
const WM_KEYLAST=264;
const WM_SYNCPAINT=136;
const WM_MOUSEACTIVATE=33;
const WM_MOUSEMOVE=512;
const WM_LBUTTONDOWN=513;
const WM_LBUTTONUP=514;
const WM_LBUTTONDBLCLK=515;
const WM_RBUTTONDOWN=516;
const WM_RBUTTONUP=517;
const WM_RBUTTONDBLCLK=518;
const WM_MBUTTONDOWN=519;
const WM_MBUTTONUP=520;
const WM_MBUTTONDBLCLK=521;
const WM_MOUSEWHEEL=522;
const WM_MOUSEFIRST=512;

struct CREATESTRUCTA {
	LPVOID    lpCreateParams;
	HINSTANCE hInstance;
	HMENU     hMenu;
	HWND      hwndParent;
	int       cy;
	int       cx;
	int       y;
	int       x;
	LONG      style;
	LPCSTR    lpszName;
	LPCSTR    lpszClass;
	DWORD     dwExStyle;
}
alias CREATESTRUCTA* LPCREATESTRUCTA;

const WM_AFXFIRST=864;
const WM_AFXLAST=895;
const WM_ASKCBFORMATNAME=780;
const WM_CANCELJOURNAL=75;
const WM_CANCELMODE=31;
const WM_CAPTURECHANGED=533;
const WM_CHANGECBCHAIN=781;
const WM_CHAR=258;
const WM_CHARTOITEM=47;
const WM_CHILDACTIVATE=34;
const WM_CLEAR=771;
const WM_CLOSE=16;
const WM_COMMAND=273;
const WM_COMMNOTIFY=68; // obsolete
const WM_COMPACTING=65;
const WM_COMPAREITEM=57;
const WM_CONTEXTMENU=123;
const WM_COPY=769;
const WM_COPYDATA=74;
const WM_CREATE=1;
const WM_CTLCOLORBTN=309;
const WM_CTLCOLORDLG=310;
const WM_CTLCOLOREDIT=307;
const WM_CTLCOLORLISTBOX=308;
const WM_CTLCOLORMSGBOX=306;
const WM_CTLCOLORSCROLLBAR=311;
const WM_CTLCOLORSTATIC=312;
const WM_CUT=768;
const WM_DEADCHAR=259;
const WM_DELETEITEM=45;
const WM_DESTROY=2;
const WM_DESTROYCLIPBOARD=775;
const WM_DEVICECHANGE=537;
const WM_DEVMODECHANGE=27;
const WM_DISPLAYCHANGE=126;
const WM_DRAWCLIPBOARD=776;
const WM_DRAWITEM=43;
const WM_DROPFILES=563;
const WM_ENABLE=10;
const WM_ENDSESSION=22;
const WM_ENTERIDLE=289;
const WM_ENTERMENULOOP=529;
const WM_ENTERSIZEMOVE=561;
const WM_ERASEBKGND=20;
const WM_EXITMENULOOP=530;
const WM_EXITSIZEMOVE=562;
const WM_FONTCHANGE=29;
const WM_GETDLGCODE=135;
const WM_GETFONT=49;
const WM_GETHOTKEY=51;
const WM_GETICON=127;
const WM_GETMINMAXINFO=36;
const WM_GETTEXT=13;
const WM_GETTEXTLENGTH=14;
const WM_HANDHELDFIRST=856;
const WM_HANDHELDLAST=863;
const WM_HELP=83;
const WM_HOTKEY=786;
const WM_HSCROLL=276;
const WM_HSCROLLCLIPBOARD=782;
const WM_ICONERASEBKGND=39;
const WM_INITDIALOG=272;
const WM_INITMENU=278;
const WM_INITMENUPOPUP=279;
const WM_INPUTLANGCHANGE=81;
const WM_INPUTLANGCHANGEREQUEST=80;
const WM_KEYDOWN=256;
const WM_KEYUP=257;
const WM_KILLFOCUS=8;
const WM_MDIACTIVATE=546;
const WM_MDICASCADE=551;
const WM_MDICREATE=544;
const WM_MDIDESTROY=545;
const WM_MDIGETACTIVE=553;
const WM_MDIICONARRANGE=552;
const WM_MDIMAXIMIZE=549;
const WM_MDINEXT=548;
const WM_MDIREFRESHMENU=564;
const WM_MDIRESTORE=547;
const WM_MDISETMENU=560;
const WM_MDITILE=550;
const WM_MEASUREITEM=44;

SHORT GET_WHEEL_DELTA_WPARAM(WPARAM wparam)
{
	return cast(SHORT) HIWORD(wparam);
}

const WA_INACTIVE=0;
const WA_ACTIVE=1;
const WA_CLICKACTIVE=2;

const SPIF_UPDATEINIFILE=1;
const SPIF_SENDWININICHANGE=2;
const SPIF_SENDCHANGE=2;
// [Redefined] ATF_ONOFFFEEDBACK=2
// [Redefined] ATF_TIMEOUTON=1
const WM_APP=32768;
const WM_ACTIVATE=6;
const WM_ACTIVATEAPP=28;

struct MSG {
	HWND   hwnd;
	UINT   message;
	WPARAM wParam;
	LPARAM lParam;
	DWORD  time;
	POINT  pt;
}
alias MSG* LPMSG, PMSG;

struct WNDCLASSA {
	UINT      style;
	WNDPROC   lpfnWndProc;
	int       cbClsExtra;
	int       cbWndExtra;
	HINSTANCE hInstance;
	HICON     hIcon;
	HCURSOR   hCursor;
	HBRUSH    hbrBackground;
	LPCSTR    lpszMenuName;
	LPCSTR    lpszClassName;
}
alias WNDCLASSA* LPWNDCLASSA, PWNDCLASSA;

struct WNDCLASSW {
	UINT      style;
	WNDPROC   lpfnWndProc;
	int       cbClsExtra;
	int       cbWndExtra;
	HINSTANCE hInstance;
	HICON     hIcon;
	HCURSOR   hCursor;
	HBRUSH    hbrBackground;
	LPCWSTR   lpszMenuName;
	LPCWSTR   lpszClassName;
}
alias WNDCLASSW* LPWNDCLASSW, PWNDCLASSW;

struct WNDCLASSEXA {
	UINT      cbSize = WNDCLASSEXA.sizeof;
	UINT      style;
	WNDPROC   lpfnWndProc;
	int       cbClsExtra;
	int       cbWndExtra;
	HINSTANCE hInstance;
	HICON     hIcon;
	HCURSOR   hCursor;
	HBRUSH    hbrBackground;
	LPCSTR    lpszMenuName;
	LPCSTR    lpszClassName;
	HICON     hIconSm;
}
alias WNDCLASSEXA* LPWNDCLASSEXA, PWNDCLASSEXA;

struct WNDCLASSEXW {
	UINT      cbSize = WNDCLASSEXW.sizeof;
	UINT      style;
	WNDPROC   lpfnWndProc;
	int       cbClsExtra;
	int       cbWndExtra;
	HINSTANCE hInstance;
	HICON     hIcon;
	HCURSOR   hCursor;
	HBRUSH    hbrBackground;
	LPCWSTR   lpszMenuName;
	LPCWSTR   lpszClassName;
	HICON     hIconSm;
}
alias WNDCLASSEXW* LPWNDCLASSEXW, PWNDCLASSEXW;

alias LRESULT function(HWND,UINT,WPARAM,LPARAM) WNDPROC;

const MFT_BITMAP = 4;
const MFT_MENUBARBREAK = 32;
const MFT_MENUBREAK = 64;
const MFT_OWNERDRAW = 256;
const MFT_RADIOCHECK = 512;
const MFT_RIGHTJUSTIFY = 0x4000;
const MFT_SEPARATOR = 0x800;
const MFT_RIGHTORDER = 0x2000L;
const MFT_STRING = 0;

const MFS_CHECKED = 8;
const MFS_DEFAULT = 4096;
const MFS_DISABLED = 3;
const MFS_ENABLED = 0;
const MFS_GRAYED = 3;
const MFS_HILITE = 128;
const MFS_UNCHECKED = 0;
const MFS_UNHILITE = 0;

const GW_HWNDNEXT = 2;
const GW_HWNDPREV = 3;
const GW_CHILD = 5;
const GW_HWNDFIRST = 0;
const GW_HWNDLAST = 1;
const GW_OWNER = 4;

const SW_HIDE = 0;
const SW_NORMAL = 1;
const SW_SHOWNORMAL = 1;
const SW_SHOWMINIMIZED = 2;
const SW_MAXIMIZE = 3;
const SW_SHOWMAXIMIZED = 3;
const SW_SHOWNOACTIVATE = 4;
const SW_SHOW = 5;
const SW_MINIMIZE = 6;
const SW_SHOWMINNOACTIVE = 7;
const SW_SHOWNA = 8;
const SW_RESTORE = 9;
const SW_SHOWDEFAULT = 10;
const SW_FORCEMINIMIZE = 11;
const SW_MAX = 11;

const MB_USERICON = 128;
const MB_ICONASTERISK = 64;
const MB_ICONEXCLAMATION = 0x30;
const MB_ICONWARNING = 0x30;
const MB_ICONERROR = 16;
const MB_ICONHAND = 16;
const MB_ICONQUESTION = 32;
const MB_OK = 0;
const MB_ABORTRETRYIGNORE = 2;
const MB_APPLMODAL = 0;
const MB_DEFAULT_DESKTOP_ONLY = 0x20000;
const MB_HELP = 0x4000;
const MB_RIGHT = 0x80000;
const MB_RTLREADING = 0x100000;
const MB_TOPMOST = 0x40000;
const MB_DEFBUTTON1 = 0;
const MB_DEFBUTTON2 = 256;
const MB_DEFBUTTON3 = 512;
const MB_DEFBUTTON4 = 0x300;
const MB_ICONINFORMATION = 64;
const MB_ICONSTOP = 16;
const MB_OKCANCEL = 1;
const MB_RETRYCANCEL = 5;

const RDW_INVALIDATE      = 1;
const RDW_INTERNALPAINT   = 2;
const RDW_ERASE           = 4;
const RDW_VALIDATE        = 8;
const RDW_NOINTERNALPAINT = 16;
const RDW_NOERASE         = 32;
const RDW_NOCHILDREN      = 64;
const RDW_ALLCHILDREN     = 128;
const RDW_UPDATENOW       = 256;
const RDW_ERASENOW        = 512;
const RDW_FRAME           = 1024;
const RDW_NOFRAME         = 2048;

const SMTO_NORMAL      = 0;
const SMTO_BLOCK       = 1;
const SMTO_ABORTIFHUNG = 2;

const SIF_ALL = 23;
const SIF_PAGE = 2;
const SIF_POS = 4;
const SIF_RANGE = 1;
const SIF_DISABLENOSCROLL = 8;
const SIF_TRACKPOS = 16;

const SWP_DRAWFRAME = 32;
const SWP_FRAMECHANGED = 32;
const SWP_HIDEWINDOW = 128;
const SWP_NOACTIVATE = 16;
const SWP_NOCOPYBITS = 256;
const SWP_NOMOVE = 2;
const SWP_NOSIZE = 1;
const SWP_NOREDRAW = 8;
const SWP_NOZORDER = 4;
const SWP_SHOWWINDOW = 64;
const SWP_NOOWNERZORDER = 512;
const SWP_NOREPOSITION = 512;
const SWP_NOSENDCHANGING = 1024;
const SWP_DEFERERASE = 8192;
const SWP_ASYNCWINDOWPOS = 16384;

const HSHELL_ACTIVATESHELLWINDOW = 3;
const HSHELL_GETMINRECT = 5;
const HSHELL_LANGUAGE = 8;
const HSHELL_REDRAW = 6;
const HSHELL_TASKMAN = 7;
const HSHELL_WINDOWACTIVATED = 4;
const HSHELL_WINDOWCREATED = 1;
const HSHELL_WINDOWDESTROYED = 2;
const HSHELL_FLASH = 32774;

const WS_EX_ACCEPTFILES = 16;
const WS_EX_APPWINDOW = 0x40000;
const WS_EX_CLIENTEDGE = 512;
const WS_EX_COMPOSITED = 0x2000000;  // XP
const WS_EX_CONTEXTHELP = 0x400;
const WS_EX_CONTROLPARENT = 0x10000;
const WS_EX_DLGMODALFRAME = 1;
const WS_EX_LAYERED = 0x80000;  // w2k
const WS_EX_LAYOUTRTL = 0x400000;  // w98, w2k
const WS_EX_LEFT = 0;
const WS_EX_LEFTSCROLLBAR = 0x4000;
const WS_EX_LTRREADING = 0;
const WS_EX_MDICHILD = 64;
const WS_EX_NOACTIVATE = 0x8000000;  // w2k
const WS_EX_NOINHERITLAYOUT = 0x100000;  // w2k
const WS_EX_NOPARENTNOTIFY = 4;
const WS_EX_OVERLAPPEDWINDOW = 0x300;
const WS_EX_PALETTEWINDOW = 0x188;
const WS_EX_RIGHT = 0x1000;
const WS_EX_RIGHTSCROLLBAR = 0;
const WS_EX_RTLREADING = 0x2000;
const WS_EX_STATICEDGE = 0x20000;
const WS_EX_TOOLWINDOW = 128;
const WS_EX_TOPMOST = 8;
const WS_EX_TRANSPARENT = 32;
const WS_EX_WINDOWEDGE = 256;

const CS_BYTEALIGNCLIENT = 4096;
const CS_BYTEALIGNWINDOW = 8192;
const CS_KEYCVTWINDOW = 4;
const CS_NOKEYCVT = 256;
const CS_CLASSDC = 64;
const CS_DBLCLKS = 8;
const CS_GLOBALCLASS = 16384;
const CS_HREDRAW = 2;
const CS_NOCLOSE = 512;
const CS_OWNDC = 32;
const CS_PARENTDC = 128;
const CS_SAVEBITS = 2048;
const CS_VREDRAW = 1;
const CS_IME = 0x10000;

const GCW_ATOM = -32;
const GCL_CBCLSEXTRA = -20;
const GCL_CBWNDEXTRA = -18;
const GCL_HBRBACKGROUND = -10;
const GCL_HCURSOR = -12;
const GCL_HICON = -14;
const GCL_HICONSM = -34;
const GCL_HMODULE = -16;
const GCL_MENUNAME = -8;
const GCL_STYLE = -26;
const GCL_WNDPROC = -24;

alias GCL_HICONSM GCLP_HICONSM;
alias GCL_HICON GCLP_HICON;
alias GCL_HCURSOR GCLP_HCURSOR;
alias GCL_HBRBACKGROUND GCLP_HBRBACKGROUND;
alias GCL_HMODULE  GCLP_HMODULE;
alias GCL_MENUNAME GCLP_MENUNAME;
alias GCL_WNDPROC  GCLP_WNDPROC;

template MAKEINTRESOURCE_T (WORD i)
{
	const LPTSTR MAKEINTRESOURCE_T = cast(LPTSTR)(i);
}

LPSTR MAKEINTRESOURCEA(WORD i)
{
	return cast(LPSTR)(i);
}

LPWSTR MAKEINTRESOURCEW(WORD i)
{
	return cast(LPWSTR)(i);
}

const IDC_ARROW       = MAKEINTRESOURCE_T!(32512);
const IDC_IBEAM       = MAKEINTRESOURCE_T!(32513);
const IDC_WAIT        = MAKEINTRESOURCE_T!(32514);
const IDC_CROSS       = MAKEINTRESOURCE_T!(32515);
const IDC_UPARROW     = MAKEINTRESOURCE_T!(32516);
const IDC_SIZENWSE    = MAKEINTRESOURCE_T!(32642);
const IDC_SIZENESW    = MAKEINTRESOURCE_T!(32643);
const IDC_SIZEWE      = MAKEINTRESOURCE_T!(32644);
const IDC_SIZENS      = MAKEINTRESOURCE_T!(32645);
const IDC_SIZEALL     = MAKEINTRESOURCE_T!(32646);
const IDC_NO          = MAKEINTRESOURCE_T!(32648);
const IDC_HAND        = MAKEINTRESOURCE_T!(32649);
const IDC_APPSTARTING = MAKEINTRESOURCE_T!(32650);
const IDC_HELP        = MAKEINTRESOURCE_T!(32651);
const IDC_ICON        = MAKEINTRESOURCE_T!(32641);
const IDC_SIZE        = MAKEINTRESOURCE_T!(32640);
const IDI_APPLICATION = MAKEINTRESOURCE_T!(32512);
const IDI_HAND        = MAKEINTRESOURCE_T!(32513);
const IDI_QUESTION    = MAKEINTRESOURCE_T!(32514);
const IDI_EXCLAMATION = MAKEINTRESOURCE_T!(32515);
const IDI_ASTERISK    = MAKEINTRESOURCE_T!(32516);
const IDI_WINLOGO     = MAKEINTRESOURCE_T!(32517);
const IDI_WARNING     = IDI_EXCLAMATION;
const IDI_ERROR       = IDI_HAND;
const IDI_INFORMATION = IDI_ASTERISK;

const MIIM_STATE = 1;
const MIIM_ID = 2;
const MIIM_SUBMENU = 4;
const MIIM_CHECKMARKS = 8;
const MIIM_TYPE = 16;
const MIIM_DATA = 32;
const MIIM_STRING = 64;
const MIIM_BITMAP = 128;
const MIIM_FTYPE = 256;

const HWND
	HWND_BROADCAST = cast(HWND)0xffff,
	HWND_BOTTOM    = cast(HWND)1,
	HWND_NOTOPMOST = cast(HWND)(-2),
	HWND_TOP       = cast(HWND)0,
	HWND_TOPMOST   = cast(HWND)(-1),
	HWND_DESKTOP   = cast(HWND)0,
	HWND_MESSAGE   = cast(HWND)(-3);

const BROADCAST_QUERY_DENY = 1112363332;
const DWORD ENUM_CURRENT_SETTINGS  = -1;
const DWORD ENUM_REGISTRY_SETTINGS = -2;

const CDS_UPDATEREGISTRY = 1;
const CDS_TEST           = 2;
const CDS_FULLSCREEN     = 4;
const CDS_GLOBAL         = 8;
const CDS_SET_PRIMARY    = 16;
const CDS_NORESET        = 0x10000000;
const CDS_SETRECT        = 0x20000000;
const CDS_RESET          = 0x40000000;

const DISP_CHANGE_RESTART    = 1;
const DISP_CHANGE_SUCCESSFUL = 0;
const DISP_CHANGE_FAILED     = -1;
const DISP_CHANGE_BADMODE    = -2;
const DISP_CHANGE_NOTUPDATED = -3;
const DISP_CHANGE_BADFLAGS   = -4;
const DISP_CHANGE_BADPARAM   = -5;

const BST_UNCHECKED     = 0;
const BST_CHECKED       = 1;
const BST_INDETERMINATE = 2;
const BST_PUSHED        = 4;
const BST_FOCUS         = 8;

const MF_BYCOMMAND  = 0;
const MF_BYPOSITION = 1024;

const OBM_BTNCORNERS = 32758;
const OBM_BTSIZE = 32761;
const OBM_CHECK = 32760;
const OBM_CHECKBOXES = 32759;
const OBM_CLOSE = 32754;
const OBM_COMBO = 32738;
const OBM_DNARROW = 32752;
const OBM_DNARROWD = 32742;
const OBM_DNARROWI = 32736;
const OBM_LFARROW = 32750;
const OBM_LFARROWI = 32734;
const OBM_LFARROWD = 32740;
const OBM_MNARROW = 32739;
const OBM_OLD_CLOSE = 32767;
const OBM_OLD_DNARROW = 32764;
const OBM_OLD_LFARROW = 32762;
const OBM_OLD_REDUCE = 32757;
const OBM_OLD_RESTORE = 32755;
const OBM_OLD_RGARROW = 32763;
const OBM_OLD_UPARROW = 32765;
const OBM_OLD_ZOOM = 32756;
const OBM_REDUCE = 32749;
const OBM_REDUCED = 32746;
const OBM_RESTORE = 32747;
const OBM_RESTORED = 32744;
const OBM_RGARROW = 32751;
const OBM_RGARROWD = 32741;
const OBM_RGARROWI = 32735;
const OBM_SIZE = 32766;
const OBM_UPARROW = 32753;
const OBM_UPARROWD = 32743;
const OBM_UPARROWI = 32737;
const OBM_ZOOM = 32748;
const OBM_ZOOMD = 32745;

const OCR_NORMAL = 32512;
const OCR_IBEAM = 32513;
const OCR_WAIT = 32514;
const OCR_CROSS = 32515;
const OCR_UP = 32516;
const OCR_SIZE = 32640;
const OCR_ICON = 32641;
const OCR_SIZENWSE = 32642;
const OCR_SIZENESW = 32643;
const OCR_SIZEWE = 32644;
const OCR_SIZENS = 32645;
const OCR_SIZEALL = 32646;
const OCR_NO = 32648;
const OCR_APPSTARTING = 32650;

const OIC_SAMPLE = 32512;
const OIC_HAND = 32513;
const OIC_QUES = 32514;
const OIC_BANG = 32515;
const OIC_NOTE = 32516;
const OIC_WINLOGO = 32517;
const OIC_WARNING = OIC_BANG;
const OIC_ERROR = OIC_HAND;
const OIC_INFORMATION = OIC_NOTE;

const HELPINFO_MENUITEM = 2;
const HELPINFO_WINDOW = 1;

const MSGF_DIALOGBOX = 0;
const MSGF_MESSAGEBOX = 1;
const MSGF_MENU = 2;
const MSGF_MOVE = 3;
const MSGF_SIZE = 4;
const MSGF_SCROLLBAR = 5;
const MSGF_NEXTWINDOW = 6;
const MSGF_MAINLOOP = 8;
const MSGF_USER = 4096;

const MOUSEEVENTF_MOVE = 1;
const MOUSEEVENTF_LEFTDOWN = 2;
const MOUSEEVENTF_LEFTUP = 4;
const MOUSEEVENTF_RIGHTDOWN = 8;
const MOUSEEVENTF_RIGHTUP = 16;
const MOUSEEVENTF_MIDDLEDOWN = 32;
const MOUSEEVENTF_MIDDLEUP = 64;
const MOUSEEVENTF_WHEEL = 0x0800;
const MOUSEEVENTF_ABSOLUTE = 32768;

const PM_NOREMOVE = 0;
const PM_REMOVE = 1;
const PM_NOYIELD = 2;

LONG DispatchMessageA( CPtr!(MSG));
LONG DispatchMessageW( CPtr!(MSG));
int DlgDirListA(HWND, LPSTR, int, int, UINT);
int DlgDirListW(HWND, LPWSTR, int, int, UINT);
int DlgDirListComboBoxA(HWND, LPSTR, int, int, UINT);
int DlgDirListComboBoxW(HWND, LPWSTR, int, int, UINT);
BOOL DlgDirSelectComboBoxExA(HWND, LPSTR, int, int);
BOOL DlgDirSelectComboBoxExW(HWND, LPWSTR, int, int);
BOOL DlgDirSelectExA(HWND, LPSTR, int, int);
BOOL DlgDirSelectExW(HWND, LPWSTR, int, int);
BOOL DragDetect(HWND, POINT);
DWORD DragObject(HWND, HWND, UINT, DWORD, HCURSOR);
BOOL DrawAnimatedRects(HWND, int, LPCRECT, LPCRECT);
BOOL DrawCaption(HWND, HDC, LPCRECT, UINT);
BOOL DrawEdge(HDC, LPRECT, UINT, UINT);
BOOL DrawFocusRect(HDC, LPCRECT);
BOOL DrawFrameControl(HDC, LPRECT, UINT, UINT);
BOOL DrawIcon(HDC, int, int, HICON);
BOOL DrawIconEx(HDC, int, int, HICON, int, int, UINT, HBRUSH, UINT);
BOOL DrawMenuBar(HWND);
//BOOL DrawStateA(HDC, HBRUSH, DRAWSTATEPROC, LPARAM, WPARAM, int, int, int, int, UINT);
//BOOL DrawStateW(HDC, HBRUSH, DRAWSTATEPROC, LPARAM, WPARAM, int, int, int, int, UINT);
int DrawTextA(HDC, LPCSTR, int, LPRECT, UINT);
int DrawTextW(HDC, LPCWSTR, int, LPRECT, UINT);
//int DrawTextExA(HDC, LPSTR, int, LPRECT, UINT, LPDRAWTEXTPARAMS);
//int DrawTextExW(HDC, LPWSTR, int, LPRECT, UINT, LPDRAWTEXTPARAMS);
BOOL EmptyClipboard();
BOOL EnableMenuItem(HMENU, UINT, UINT);
BOOL EnableScrollBar(HWND, UINT, UINT);
BOOL EnableWindow(HWND, BOOL);
//BOOL EndDeferWindowPos(HDWP);
BOOL EndDialog(HWND, int);
BOOL EndMenu();
//BOOL EndPaint(HWND, CPtr!(PAINTSTRUCT));
//BOOL EnumChildWindows(HWND, ENUMWINDOWSPROC, LPARAM);
UINT EnumClipboardFormats(UINT);
//BOOL EnumDesktopsA(HWINSTA, DESKTOPENUMPROCA, LPARAM);
//BOOL EnumDesktopsW(HWINSTA, DESKTOPENUMPROCW, LPARAM);
//BOOL EnumDesktopWindows(HDESK, ENUMWINDOWSPROC, LPARAM);
BOOL EnumDisplaySettingsA(LPCSTR, DWORD, PDEVMODEA);
//BOOL EnumDisplaySettingsW(LPCWSTR, DWORD, PDEVMODEW);

//BOOL EnumDisplayDevicesA(LPCSTR, DWORD, PDISPLAY_DEVICEA, DWORD);
//BOOL EnumDisplayDevicesW(LPCWSTR, DWORD, PDISPLAY_DEVICEW, DWORD);

//int EnumPropsA(HWND, PROPENUMPROCA);
//int EnumPropsW(HWND, PROPENUMPROCW);
//int EnumPropsExA(HWND, PROPENUMPROCEXA, LPARAM);
//int EnumPropsExW(HWND, PROPENUMPROCEXW, LPARAM);

//BOOL EnumThreadWindows(DWORD, WNDENUMPROC, LPARAM);
//BOOL EnumWindows(WNDENUMPROC, LPARAM);
//BOOL EnumWindowStationsA(WINSTAENUMPROCA, LPARAM);
//BOOL EnumWindowStationsW(WINSTAENUMPROCW, LPARAM);
BOOL EqualRect(LPCRECT, LPCRECT);

BOOL ExitWindowsEx(UINT, DWORD);
HWND FindWindowA(LPCSTR, LPCSTR);
HWND FindWindowExA(HWND, HWND, LPCSTR, LPCSTR);
HWND FindWindowExW(HWND, HWND, LPCWSTR, LPCWSTR);
HWND FindWindowW(LPCWSTR, LPCWSTR);
BOOL FlashWindow(HWND, BOOL);

int FrameRect(HDC, LPCRECT, HBRUSH);
BOOL FrameRgn(HDC, HRGN, HBRUSH, int, int);
HWND GetActiveWindow();
HWND GetAncestor(HWND, UINT);
SHORT GetAsyncKeyState(int);
HWND GetCapture();
UINT GetCaretBlinkTime();
BOOL GetCaretPos(LPPOINT);
BOOL GetClassInfoA(HINSTANCE, LPCSTR, LPWNDCLASSA);
BOOL GetClassInfoExA(HINSTANCE, LPCSTR, LPWNDCLASSEXA);
BOOL GetClassInfoW(HINSTANCE, LPCWSTR, LPWNDCLASSW);
BOOL GetClassInfoExW(HINSTANCE, LPCWSTR, LPWNDCLASSEXW);
DWORD GetClassLongA(HWND, int);
DWORD GetClassLongW(HWND, int);
int GetClassNameA(HWND, LPSTR, int);
int GetClassNameW(HWND, LPWSTR, int);
WORD GetClassWord(HWND, int);
BOOL GetClientRect(HWND, LPRECT);
HANDLE GetClipboardData(UINT);
int GetClipboardFormatNameA(UINT, LPSTR, int);
int GetClipboardFormatNameW(UINT, LPWSTR, int);
HWND GetClipboardOwner();
HWND GetClipboardViewer();
BOOL GetClipCursor(LPRECT);
BOOL GetCursorPos(LPPOINT);
HDC GetDC(HWND);
HDC GetDCEx(HWND, HRGN, DWORD);
HWND GetDesktopWindow();
int GetDialogBaseUnits();
int GetDlgCtrlID(HWND);
HWND GetDlgItem(HWND, int);
UINT GetDlgItemInt(HWND, int, PBOOL, BOOL);
UINT GetDlgItemTextA(HWND, int, LPSTR, int);
UINT GetDlgItemTextW(HWND, int, LPWSTR, int);
UINT GetDoubleClickTime();
HWND GetFocus();
HWND GetForegroundWindow();

//BOOL GetIconInfo(HICON, PICONINFO);
BOOL GetInputState();
UINT GetKBCodePage();
HKL GetKeyboardLayout(DWORD);
UINT GetKeyboardLayoutList(int, HKL*);
BOOL GetKeyboardLayoutNameA(LPSTR);
BOOL GetKeyboardLayoutNameW(LPWSTR);
BOOL GetKeyboardState(PBYTE);
int GetKeyboardType(int);
int GetKeyNameTextA(LONG, LPSTR, int);
int GetKeyNameTextW(LONG, LPWSTR, int);
SHORT GetKeyState(int);
HWND GetLastActivePopup(HWND);
HMENU GetMenu(HWND);
LONG GetMenuCheckMarkDimensions();
DWORD GetMenuContextHelpId(HMENU);
UINT GetMenuDefaultItem(HMENU, UINT, UINT);
int GetMenuItemCount(HMENU);
UINT GetMenuItemID(HMENU, int);
//BOOL GetMenuItemInfoA(HMENU, UINT, BOOL, LPMENUITEMINFOA);
//BOOL GetMenuItemInfoW(HMENU, UINT, BOOL, LPMENUITEMINFOW);
BOOL GetMenuItemRect(HWND, HMENU, UINT, LPRECT);
UINT GetMenuState(HMENU, UINT, UINT);
int GetMenuStringA(HMENU, UINT, LPSTR, int, UINT);
int GetMenuStringW(HMENU, UINT, LPWSTR, int, UINT);
BOOL GetMessageA(LPMSG, HWND, UINT, UINT);
BOOL GetMessageW(LPMSG, HWND, UINT, UINT);
LONG GetMessageExtraInfo();
DWORD GetMessagePos();
LONG GetMessageTime();

HWND GetNextDlgGroupItem(HWND, HWND, BOOL);
HWND GetNextDlgTabItem(HWND, HWND, BOOL);

HWND GetOpenClipboardWindow();
HWND GetParent(HWND);
int GetPriorityClipboardFormat(UINT*, int);
HANDLE GetPropA(HWND, LPCSTR);
HANDLE GetPropW(HWND, LPCWSTR);

DWORD GetQueueStatus(UINT);
//BOOL GetScrollInfo(HWND, int, LPSCROLLINFO);
int GetScrollPos(HWND, int);
BOOL GetScrollRange(HWND, int, LPINT, LPINT);

HMENU GetSubMenu(HMENU, int);
DWORD GetSysColor(int);
HBRUSH GetSysColorBrush(int);

HMENU GetSystemMenu(HWND, BOOL);
int GetSystemMetrics(int);
DWORD GetTabbedTextExtentA(HDC, LPCSTR, int, int, LPINT);
DWORD GetTabbedTextExtentW(HDC, LPCWSTR, int, int, LPINT);
LONG GetWindowLongA(HWND, int);
LONG GetWindowLongW(HWND, int);

HDESK GetThreadDesktop(DWORD);
HWND GetTopWindow(HWND);
BOOL GetUpdateRect(HWND, LPRECT, BOOL);
int GetUpdateRgn(HWND, HRGN, BOOL);
BOOL GetUserObjectInformationA(HANDLE, int, PVOID, DWORD, PDWORD);
BOOL GetUserObjectInformationW(HANDLE, int, PVOID, DWORD, PDWORD);
//BOOL GetUserObjectSecurity(HANDLE, PSECURITY_INFORMATION, PSECURITY_DESCRIPTOR, DWORD, PDWORD);
HWND GetWindow(HWND, UINT);
DWORD GetWindowContextHelpId(HWND);
HDC GetWindowDC(HWND);
//BOOL GetWindowPlacement(HWND, WINDOWPLACEMENT*);
BOOL GetWindowRect(HWND, LPRECT);
int GetWindowRgn(HWND, HRGN);
int GetWindowTextA(HWND, LPSTR, int);
int GetWindowTextLengthA(HWND);
int GetWindowTextLengthW(HWND);
int GetWindowTextW(HWND, LPWSTR, int);
WORD GetWindowWord(HWND, int);
//BOOL GetAltTabInfoA(HWND, int, PALTTABINFO, LPSTR, UINT);
//BOOL GetAltTabInfoW(HWND, int, PALTTABINFO, LPWSTR, UINT);
//BOOL GetComboBoxInfo(HWND, PCOMBOBOXINFO);
//BOOL GetCursorInfo(PCURSORINFO);
//BOOL GetLastInputInfo(PLASTINPUTINFO);
DWORD GetListBoxInfo(HWND);
//BOOL GetMenuBarInfo(HWND, LONG, LONG, PMENUBARINFO);
//BOOL GetMenuInfo(HMENU, LPMENUINFO);
//BOOL GetScrollBarInfo(HWND, LONG, PSCROLLBARINFO);
//BOOL GetTitleBarInfo(HWND, PTITLEBARINFO);
//BOOL GetWindowInfo(HWND, PWINDOWINFO);
UINT GetWindowModuleFileNameA(HWND, LPSTR, UINT);
UINT GetWindowModuleFileNameW(HWND, LPWSTR, UINT);
//BOOL GrayStringA(HDC, HBRUSH, GRAYSTRINGPROC, LPARAM, int, int, int, int, int);
//BOOL GrayStringW(HDC, HBRUSH, GRAYSTRINGPROC, LPARAM, int, int, int, int, int);
BOOL HideCaret(HWND);
BOOL HiliteMenuItem(HWND, HMENU, UINT, UINT);
BOOL InflateRect(LPRECT, int, int);
BOOL InSendMessage();
BOOL InsertMenuA(HMENU, UINT, UINT, UINT, LPCSTR);
BOOL InsertMenuW(HMENU, UINT, UINT, UINT, LPCWSTR);
//BOOL InsertMenuItemA(HMENU, UINT, BOOL, LPCMENUITEMINFOA);
//BOOL InsertMenuItemW(HMENU, UINT, BOOL, LPCMENUITEMINFOW);
INT InternalGetWindowText(HWND, LPWSTR, INT);
BOOL IntersectRect(LPRECT, LPCRECT, LPCRECT);
BOOL InvalidateRect(HWND, LPCRECT, BOOL);
BOOL InvalidateRgn(HWND, HRGN, BOOL);
BOOL InvertRect(HDC, LPCRECT);
BOOL IsCharAlphaA(CHAR ch);
BOOL IsCharAlphaNumericA(CHAR);
BOOL IsCharAlphaNumericW(WCHAR);
BOOL IsCharAlphaW(WCHAR);
BOOL IsCharLowerA(CHAR);
BOOL IsCharLowerW(WCHAR);
BOOL IsCharUpperA(CHAR);
BOOL IsCharUpperW(WCHAR);
BOOL IsChild(HWND, HWND);
BOOL IsClipboardFormatAvailable(UINT);
BOOL IsDialogMessageA(HWND, LPMSG);
BOOL IsDialogMessageW(HWND, LPMSG);
UINT IsDlgButtonChecked(HWND, int);
BOOL IsIconic(HWND);
BOOL IsMenu(HMENU);
BOOL IsRectEmpty(LPCRECT);
BOOL IsWindow(HWND);
BOOL IsWindowEnabled(HWND);
BOOL IsWindowUnicode(HWND);
BOOL IsWindowVisible(HWND);
BOOL IsZoomed(HWND);
void keybd_event(BYTE, BYTE, DWORD, DWORD);
BOOL KillTimer(HWND, UINT);
HACCEL LoadAcceleratorsA(HINSTANCE, LPCSTR);
HACCEL LoadAcceleratorsW(HINSTANCE, LPCWSTR);
HBITMAP LoadBitmapA(HINSTANCE, LPCSTR);
HBITMAP LoadBitmapW(HINSTANCE, LPCWSTR);
HCURSOR LoadCursorA(HINSTANCE, LPCSTR);
HCURSOR LoadCursorFromFileA(LPCSTR);
HCURSOR LoadCursorFromFileW(LPCWSTR);
HCURSOR LoadCursorW(HINSTANCE, LPCWSTR);
HICON LoadIconA(HINSTANCE, LPCSTR);
HICON LoadIconW(HINSTANCE, LPCWSTR);
HANDLE LoadImageA(HINSTANCE, LPCSTR, UINT, int, int, UINT);
HANDLE LoadImageW(HINSTANCE, LPCWSTR, UINT, int, int, UINT);
HKL LoadKeyboardLayoutA(LPCSTR, UINT);
HKL LoadKeyboardLayoutW(LPCWSTR, UINT);
HMENU LoadMenuA(HINSTANCE, LPCSTR);
//HMENU LoadMenuIndirectA( CPtr!(MENUTEMPLATE));
//HMENU LoadMenuIndirectW( CPtr!(MENUTEMPLATE));
HMENU LoadMenuW(HINSTANCE, LPCWSTR);
int LoadStringA(HINSTANCE, UINT, LPSTR, int);
int LoadStringW(HINSTANCE, UINT, LPWSTR, int);
BOOL LockWindowUpdate(HWND);
int LookupIconIdFromDirectory(PBYTE, BOOL);
int LookupIconIdFromDirectoryEx(PBYTE, BOOL, int, int, UINT);
BOOL MapDialogRect(HWND, LPRECT);
UINT MapVirtualKeyA(UINT, UINT);
UINT MapVirtualKeyExA(UINT, UINT, HKL);
UINT MapVirtualKeyExW(UINT, UINT, HKL);
UINT MapVirtualKeyW(UINT, UINT);
int MapWindowPoints(HWND, HWND, LPPOINT, UINT);
int MenuItemFromPoint(HWND, HMENU, POINT);
BOOL MessageBeep(UINT);
int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
int MessageBoxW(HWND, LPCWSTR, LPCWSTR, UINT);
int MessageBoxExA(HWND, LPCSTR, LPCSTR, UINT, WORD);
int MessageBoxExW(HWND, LPCWSTR, LPCWSTR, UINT, WORD);
//int MessageBoxIndirectA(CPtr!(MSGBOXPARAMSA));
//int MessageBoxIndirectW(CPtr!(MSGBOXPARAMSW));
BOOL ModifyMenuA(HMENU, UINT, UINT, UINT, LPCSTR);
BOOL ModifyMenuW(HMENU, UINT, UINT, UINT, LPCWSTR);
void mouse_event(DWORD, DWORD, DWORD, DWORD, ULONG_PTR);
BOOL MoveWindow(HWND, int, int, int, int, BOOL);
DWORD MsgWaitForMultipleObjects(DWORD, CPtr!(HANDLE), BOOL, DWORD, DWORD);
DWORD MsgWaitForMultipleObjectsEx(DWORD, CPtr!(HANDLE), DWORD, DWORD, DWORD);
DWORD OemKeyScan(WORD);
BOOL OemToCharA(LPCSTR, LPSTR);
BOOL OemToCharBuffA(LPCSTR, LPSTR, DWORD);
BOOL OemToCharBuffW(LPCSTR, LPWSTR, DWORD);
BOOL OemToCharW(LPCSTR, LPWSTR);
BOOL OffsetRect(LPRECT, int, int);
BOOL OpenClipboard(HWND);
HDESK OpenDesktopA(LPSTR, DWORD, BOOL, DWORD);
HDESK OpenDesktopW(LPWSTR, DWORD, BOOL, DWORD);
BOOL OpenIcon(HWND);
HDESK OpenInputDesktop(DWORD, BOOL, DWORD);
HWINSTA OpenWindowStationA(LPSTR, BOOL, DWORD);
HWINSTA OpenWindowStationW(LPWSTR, BOOL, DWORD);
BOOL PaintDesktop(HDC);
BOOL PeekMessageA(LPMSG, HWND, UINT, UINT, UINT);
BOOL PeekMessageW(LPMSG, HWND, UINT, UINT, UINT);
BOOL PostMessageA(HWND, UINT, WPARAM, LPARAM);
BOOL PostMessageW(HWND, UINT, WPARAM, LPARAM);
void PostQuitMessage(int);
BOOL PostThreadMessageA(DWORD, UINT, WPARAM, LPARAM);
BOOL PostThreadMessageW(DWORD, UINT, WPARAM, LPARAM);
BOOL PtInRect(LPCRECT, POINT);
HWND RealChildWindowFromPoint(HWND, POINT);
UINT RealGetWindowClassA(HWND, LPSTR, UINT);
UINT RealGetWindowClassW(HWND, LPWSTR, UINT);
BOOL RedrawWindow(HWND, LPCRECT, HRGN, UINT);
ATOM RegisterClassA(CPtr!(WNDCLASSA));
ATOM RegisterClassW(CPtr!(WNDCLASSW));
ATOM RegisterClassExA(CPtr!(WNDCLASSEXA));
ATOM RegisterClassExW(CPtr!(WNDCLASSEXW));
UINT RegisterClipboardFormatA(LPCSTR);
UINT RegisterClipboardFormatW(LPCWSTR);
BOOL RegisterHotKey(HWND, int, UINT, UINT);
UINT RegisterWindowMessageA(LPCSTR);
UINT RegisterWindowMessageW(LPCWSTR);
BOOL ReleaseCapture();
int ReleaseDC(HWND, HDC);
BOOL RemoveMenu(HMENU, UINT, UINT);
HANDLE RemovePropA(HWND, LPCSTR);
HANDLE RemovePropW(HWND, LPCWSTR);
BOOL ReplyMessage(LRESULT);
BOOL ScreenToClient(HWND, LPPOINT);
BOOL ScrollDC(HDC, int, int, LPCRECT, LPCRECT, HRGN, LPRECT);
BOOL ScrollWindow(HWND, int, int, LPCRECT, LPCRECT);
int ScrollWindowEx(HWND, int, int, LPCRECT, LPCRECT, HRGN, LPRECT, UINT);
LONG SendDlgItemMessageA(HWND, int, UINT, WPARAM, LPARAM);
LONG SendDlgItemMessageW(HWND, int, UINT, WPARAM, LPARAM);
LRESULT SendMessageA(HWND, UINT, WPARAM, LPARAM);
//BOOL SendMessageCallbackA(HWND, UINT, WPARAM, LPARAM, SENDASYNCPROC, DWORD);
//BOOL SendMessageCallbackW(HWND, UINT, WPARAM, LPARAM, SENDASYNCPROC, DWORD);
LRESULT SendMessageTimeoutA(HWND, UINT, WPARAM, LPARAM, UINT, UINT, PDWORD);
LRESULT SendMessageTimeoutW(HWND, UINT, WPARAM, LPARAM, UINT, UINT, PDWORD);
LRESULT SendMessageW(HWND, UINT, WPARAM, LPARAM);
BOOL SendNotifyMessageA(HWND, UINT, WPARAM, LPARAM);
BOOL SendNotifyMessageW(HWND, UINT, WPARAM, LPARAM);
HWND SetActiveWindow(HWND);
HWND SetCapture(HWND hWnd);
BOOL SetCaretBlinkTime(UINT);
BOOL SetCaretPos(int, int);
DWORD SetClassLongA(HWND, int, LONG);
DWORD SetClassLongW(HWND, int, LONG);
WORD SetClassWord(HWND, int, WORD);
HANDLE SetClipboardData(UINT, HANDLE);
HWND SetClipboardViewer(HWND);
HCURSOR SetCursor(HCURSOR);
BOOL SetCursorPos(int, int);
void SetDebugErrorLevel(DWORD);
BOOL SetDlgItemInt(HWND, int, UINT, BOOL);
BOOL SetDlgItemTextA(HWND, int, LPCSTR);
BOOL SetDlgItemTextW(HWND, int, LPCWSTR);
BOOL SetDoubleClickTime(UINT);
HWND SetFocus(HWND);
BOOL SetForegroundWindow(HWND);
BOOL SetKeyboardState(PBYTE);
BOOL SetMenu(HWND, HMENU);
BOOL SetMenuContextHelpId(HMENU, DWORD);
BOOL SetMenuDefaultItem(HMENU, UINT, UINT);
//BOOL SetMenuInfo(HMENU, LPCMENUINFO);
BOOL SetMenuItemBitmaps(HMENU, UINT, UINT, HBITMAP, HBITMAP);
//BOOL SetMenuItemInfoA(HMENU, UINT, BOOL, LPCMENUITEMINFOA);
//BOOL SetMenuItemInfoW( HMENU, UINT, BOOL, LPCMENUITEMINFOW);
LPARAM SetMessageExtraInfo(LPARAM);
BOOL SetMessageQueue(int);
HWND SetParent(HWND, HWND);
BOOL SetProcessWindowStation(HWINSTA);
BOOL SetPropA(HWND, LPCSTR, HANDLE);
BOOL SetPropW(HWND, LPCWSTR, HANDLE);
BOOL SetRect(LPRECT, int, int, int, int);
BOOL SetRectEmpty(LPRECT);
//int SetScrollInfo(HWND, int, LPCSCROLLINFO, BOOL);
int SetScrollPos(HWND, int, int, BOOL);
BOOL SetScrollRange(HWND, int, int, int, BOOL);
BOOL SetSysColors(int, CPtr!(INT) , CPtr!(COLORREF) );
BOOL SetSystemCursor(HCURSOR, DWORD);
BOOL SetThreadDesktop(HDESK);
//UINT SetTimer(HWND, UINT, UINT, TIMERPROC);
BOOL SetUserObjectInformationA(HANDLE, int, PVOID, DWORD);
BOOL SetUserObjectInformationW(HANDLE, int, PVOID, DWORD);
//BOOL SetUserObjectSecurity(HANDLE, PSECURITY_INFORMATION, PSECURITY_DESCRIPTOR);
BOOL SetWindowContextHelpId(HWND, DWORD);
LONG SetWindowLongA(HWND, int, LONG);
LONG SetWindowLongW(HWND, int, LONG);
//BOOL SetWindowPlacement(HWND hWnd, CPtr!(WINDOWPLACEMENT));
BOOL SetWindowPos(HWND, HWND, int, int, int, int, UINT);
int SetWindowRgn(HWND, HRGN, BOOL);
//HHOOK SetWindowsHookA(int, HOOKPROC);
//HHOOK SetWindowsHookW(int, HOOKPROC);
//HHOOK SetWindowsHookExA(int, HOOKPROC, HINSTANCE, DWORD);
//HHOOK SetWindowsHookExW(int, HOOKPROC, HINSTANCE, DWORD);
BOOL SetWindowTextA(HWND, LPCSTR);
BOOL SetWindowTextW(HWND, LPCWSTR);
WORD SetWindowWord(HWND, int, WORD);
BOOL ShowCaret(HWND);
int ShowCursor(BOOL);
BOOL ShowOwnedPopups(HWND, BOOL);
BOOL ShowScrollBar(HWND, int, BOOL);
BOOL ShowWindow(HWND, int);
BOOL ShowWindowAsync(HWND, int);
BOOL SubtractRect(LPRECT, LPCRECT, LPCRECT);
BOOL SwapMouseButton(BOOL);
BOOL SwitchDesktop(HDESK);
BOOL SystemParametersInfoA(UINT, UINT, PVOID, UINT);
BOOL SystemParametersInfoW(UINT, UINT, PVOID, UINT);
LONG TabbedTextOutA(HDC, int, int, LPCSTR, int, int, LPINT, int);
LONG TabbedTextOutW(HDC, int, int, LPCWSTR, int, int, LPINT, int);
WORD TileWindows(HWND, UINT, LPCRECT, UINT, CPtr!(HWND) );
int ToAscii(UINT, UINT, PBYTE, LPWORD, UINT);
int ToAsciiEx(UINT, UINT, PBYTE, LPWORD, UINT, HKL);
int ToUnicode(UINT, UINT, PBYTE, LPWSTR, int, UINT);
int ToUnicodeEx(UINT, UINT, PBYTE, LPWSTR, int, UINT, HKL);
//BOOL TrackMouseEvent(LPTRACKMOUSEEVENT);
BOOL TrackPopupMenu(HMENU, UINT, int, int, int, HWND, LPCRECT);
//BOOL TrackPopupMenuEx(HMENU, UINT, int, int, HWND, LPTPMPARAMS);
int TranslateAcceleratorA(HWND, HACCEL, LPMSG);
int TranslateAcceleratorW(HWND, HACCEL, LPMSG);
BOOL TranslateMDISysAccel(HWND, LPMSG);
BOOL TranslateMessage( CPtr!(MSG));
//BOOL UnhookWindowsHook(int, HOOKPROC);
//BOOL UnhookWindowsHookEx(HHOOK);
BOOL UnionRect(LPRECT, LPCRECT, LPCRECT);
BOOL UnloadKeyboardLayout(HKL);
BOOL UnregisterClassA(LPCSTR, HINSTANCE);
BOOL UnregisterClassW(LPCWSTR, HINSTANCE);
BOOL UnregisterHotKey(HWND, int);
BOOL UpdateWindow(HWND);
BOOL ValidateRect(HWND, LPCRECT);
BOOL ValidateRgn(HWND, HRGN);
SHORT VkKeyScanA(CHAR);
SHORT VkKeyScanExA(CHAR, HKL);
SHORT VkKeyScanExW(WCHAR, HKL);
SHORT VkKeyScanW(WCHAR);
DWORD WaitForInputIdle(HANDLE, DWORD);
BOOL WaitMessage();
HWND WindowFromDC(HDC hDC);
HWND WindowFromPoint(POINT);
UINT WinExec(LPCSTR, UINT);
BOOL WinHelpA(HWND, LPCSTR, UINT, DWORD);
BOOL WinHelpW(HWND, LPCWSTR, UINT, DWORD);

HKL ActivateKeyboardLayout(HKL, UINT);
BOOL AdjustWindowRect(LPRECT, DWORD, BOOL);
BOOL AdjustWindowRectEx(LPRECT, DWORD, BOOL, DWORD);
BOOL AnyPopup();
BOOL AppendMenuA(HMENU, UINT, UINT_PTR, LPCSTR);
BOOL AppendMenuW(HMENU, UINT, UINT_PTR, LPCWSTR);
UINT ArrangeIconicWindows(HWND);
BOOL AttachThreadInput(DWORD, DWORD, BOOL);
//HDWP BeginDeferWindowPos(int);
//HDC BeginPaint(HWND, LPPAINTSTRUCT);
BOOL BringWindowToTop(HWND);
BOOL CallMsgFilterA(LPMSG, INT);
BOOL CallMsgFilterW(LPMSG, INT);
//LRESULT CallNextHookEx(HHOOK, int, WPARAM, LPARAM);
LRESULT CallWindowProcA(WNDPROC, HWND, UINT, WPARAM, LPARAM);
LRESULT CallWindowProcW(WNDPROC, HWND, UINT, WPARAM, LPARAM);
WORD CascadeWindows(HWND, UINT, LPCRECT, UINT, CPtr!(HWND));
BOOL ChangeClipboardChain(HWND, HWND);

LONG ChangeDisplaySettingsA(PDEVMODEA, DWORD);
//LONG ChangeDisplaySettingsW(PDEVMODEW, DWORD);
LONG ChangeDisplaySettingsExA(LPCSTR, LPDEVMODEA, HWND, DWORD, LPVOID);
//LONG ChangeDisplaySettingsExW(LPCWSTR, LPDEVMODEW, HWND, DWORD, LPVOID);

BOOL ChangeMenuA(HMENU, UINT, LPCSTR, UINT, UINT);
BOOL ChangeMenuW(HMENU, UINT, LPCWSTR, UINT, UINT);
LPSTR CharLowerA(LPSTR);
LPWSTR CharLowerW(LPWSTR);
DWORD CharLowerBuffA(LPSTR, DWORD);
DWORD CharLowerBuffW(LPWSTR, DWORD);
LPSTR CharNextA(LPCSTR);
LPWSTR CharNextW(LPCWSTR);
LPSTR CharNextExA(WORD, LPCSTR, DWORD);
LPWSTR CharNextExW(WORD, LPCWSTR, DWORD);
LPSTR CharPrevA(LPCSTR, LPCSTR);
LPWSTR CharPrevW(LPCWSTR, LPCWSTR);
LPSTR CharPrevExA(WORD, LPCSTR, LPCSTR, DWORD);
LPWSTR CharPrevExW(WORD, LPCWSTR, LPCWSTR, DWORD);
BOOL CharToOemA(LPCSTR, LPSTR);
BOOL CharToOemW(LPCWSTR, LPSTR);
BOOL CharToOemBuffA(LPCSTR, LPSTR, DWORD);
BOOL CharToOemBuffW(LPCWSTR, LPSTR, DWORD);
LPSTR CharUpperA(LPSTR);
LPWSTR CharUpperW(LPWSTR);
DWORD CharUpperBuffA(LPSTR, DWORD);
DWORD CharUpperBuffW(LPWSTR, DWORD);
BOOL CheckDlgButton(HWND, int, UINT);
DWORD CheckMenuItem(HMENU, UINT, UINT);
BOOL CheckMenuRadioItem(HMENU, UINT, UINT, UINT, UINT);
BOOL CheckRadioButton(HWND, int, int, int);
HWND ChildWindowFromPoint(HWND, POINT);
HWND ChildWindowFromPointEx(HWND, POINT, UINT);
BOOL ClientToScreen(HWND, LPPOINT);
BOOL ClipCursor(LPCRECT);
BOOL CloseClipboard();
BOOL CloseDesktop(HDESK);
BOOL CloseWindow(HWND);
BOOL CloseWindowStation(HWINSTA);
//int CopyAcceleratorTableA(HACCEL, LPACCEL, int);
//int CopyAcceleratorTableW(HACCEL, LPACCEL, int);

HICON CopyIcon(HICON);
HANDLE CopyImage(HANDLE, UINT, int, int, UINT);
BOOL CopyRect(LPRECT, LPCRECT);
int CountClipboardFormats();
//HACCEL CreateAcceleratorTableA(LPACCEL, int);
//HACCEL CreateAcceleratorTableW(LPACCEL, int);
BOOL CreateCaret(HWND, HBITMAP, int, int);
HCURSOR CreateCursor(HINSTANCE, int, int, int, int, PCVOID, PCVOID);

//HDESK CreateDesktopA(LPCSTR, LPCSTR, LPDEVMODEA, DWORD, ACCESS_MASK, LPSECURITY_ATTRIBUTES);
//HDESK CreateDesktopW(LPCWSTR, LPCWSTR, LPDEVMODEW, DWORD, ACCESS_MASK, LPSECURITY_ATTRIBUTES);

//HWND CreateDialogParamA(HINSTANCE, LPCSTR, HWND, DLGPROC, LPARAM);
//HWND CreateDialogParamW(HINSTANCE, LPCWSTR, HWND, DLGPROC, LPARAM);
//HWND CreateDialogIndirectParamA(HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC, LPARAM);
//HWND CreateDialogIndirectParamW(HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC, LPARAM);

HICON CreateIcon(HINSTANCE, int, int, BYTE, BYTE, CPtr!(BYTE), BYTE*);
HICON CreateIconFromResource(PBYTE, DWORD, BOOL, DWORD);
HICON CreateIconFromResourceEx(PBYTE, DWORD, BOOL, DWORD, int, int, UINT);
//HICON CreateIconIndirect(PICONINFO);
HWND CreateMDIWindowA(LPCSTR, LPCSTR, DWORD, int, int, int, int, HWND, HINSTANCE, LPARAM);
HWND CreateMDIWindowW(LPCWSTR, LPCWSTR, DWORD, int, int, int, int, HWND, HINSTANCE, LPARAM);
HMENU CreateMenu();
HMENU CreatePopupMenu();

HWND CreateWindowExA(DWORD, LPCSTR, LPCSTR, DWORD, int, int, int, int, HWND, HMENU, HINSTANCE, LPVOID);
HWND CreateWindowExW(DWORD, LPCWSTR, LPCWSTR, DWORD, int, int, int, int, HWND, HMENU, HINSTANCE, LPVOID);

//HWINSTA CreateWindowStationA(LPSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
//HWINSTA CreateWindowStationW(LPWSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
LRESULT DefDlgProcA(HWND, UINT, WPARAM, LPARAM);
LRESULT DefDlgProcW(HWND, UINT, WPARAM, LPARAM);
//HDWP DeferWindowPos(HDWP, HWND, HWND, int, int, int, int, UINT);
LRESULT DefFrameProcA(HWND, HWND, UINT, WPARAM, LPARAM);
LRESULT DefFrameProcW(HWND, HWND, UINT, WPARAM, LPARAM);

LRESULT DefMDIChildProcA(HWND, UINT, WPARAM, LPARAM);
LRESULT DefMDIChildProcW(HWND, UINT, WPARAM, LPARAM);
LRESULT DefWindowProcA(HWND, UINT, WPARAM, LPARAM);
LRESULT DefWindowProcW(HWND, UINT, WPARAM, LPARAM);
BOOL DeleteMenu(HMENU, UINT, UINT);
BOOL DeregisterShellHookWindow(HWND);
BOOL DestroyAcceleratorTable(HACCEL);
BOOL DestroyCaret();
BOOL DestroyCursor(HCURSOR);
BOOL DestroyIcon(HICON);
BOOL DestroyMenu(HMENU);
BOOL DestroyWindow(HWND);

//int DialogBoxParamA(HINSTANCE, LPCSTR, HWND, DLGPROC, LPARAM);
//int DialogBoxParamW(HINSTANCE, LPCWSTR, HWND, DLGPROC, LPARAM);
//int DialogBoxIndirectParamA(HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC, LPARAM);
//int DialogBoxIndirectParamW(HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC, LPARAM);

const CWP_ALL             = 0;
const CWP_SKIPINVISIBLE   = 1;
const CWP_SKIPDISABLED    = 2;
const CWP_SKIPTRANSPARENT = 4;

const IMAGE_BITMAP=0;
const IMAGE_ICON=1;
const IMAGE_CURSOR=2;
const IMAGE_ENHMETAFILE=3;

const DF_ALLOWOTHERACCOUNTHOOK = 1;

const DESKTOP_READOBJECTS     = 1;
const DESKTOP_CREATEWINDOW    = 2;
const DESKTOP_CREATEMENU      = 4;
const DESKTOP_HOOKCONTROL     = 8;
const DESKTOP_JOURNALRECORD   = 16;
const DESKTOP_JOURNALPLAYBACK = 32;
const DESKTOP_ENUMERATE       = 64;
const DESKTOP_WRITEOBJECTS    = 128;
const DESKTOP_SWITCHDESKTOP   = 256;

const CW_USEDEFAULT       = 0x80000000;