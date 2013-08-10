module win32.windef;
import win32.basetsd;
import win32.winnt;

enum NULL = null;
//~ alias null NULL;
//~ const void  *NULL = null;
alias ubyte  BYTE;
alias ubyte *PBYTE, LPBYTE;
alias ushort USHORT, WORD, ATOM;
alias ushort*PUSHORT, PWORD, LPWORD;
alias size_t   ULONG, DWORD, UINT, COLORREF;
alias uint  *PULONG, PDWORD, LPDWORD, PUINT, LPUINT;
alias size_t WINBOOL, BOOL, INT, LONG, HFILE, HRESULT;
alias size_t *PWINBOOL, LPWINBOOL, PBOOL, LPBOOL, PINT, LPINT, LPLONG;
alias float FLOAT;
alias float*PFLOAT;
alias CPtr!(void) PCVOID, LPCVOID;

alias UINT_PTR WPARAM;
alias LONG_PTR LPARAM, LRESULT;

alias HANDLE HGLOBAL, HLOCAL, GLOBALHANDLE, LOCALHANDLE, HGDIOBJ, HACCEL,
	HBITMAP, HBRUSH, HCOLORSPACE, HDC, HGLRC, HDESK, HENHMETAFILE, HFONT,
	HICON, HINSTANCE, HKEY, HMENU, HMETAFILE, HMODULE, HMONITOR, HPALETTE, HPEN,
	HRGN, HRSRC, HSTR, HTASK, HWND, HWINSTA, HKL, HCURSOR;
alias HANDLE*PHKEY;

ushort LOWORD(uint l)
{
	return cast(ushort) l;
}


ushort HIWORD(uint l)
{
	return cast(ushort) (l >>> 16);
}

uint LOWORD(ulong l)
{
	return cast(uint) l;
}


uint HIWORD(ulong l)
{
	return cast(uint) (l >>> 16);
}


ubyte LOBYTE(ushort w)
{
	return cast(ubyte) w;
}


ubyte HIBYTE(ushort w)
{
	return cast(ubyte) (w >>> 8);
}

struct RECT
{
	LONG left;
	LONG top;
	LONG right;
	LONG bottom;
}
alias RECT RECTL;
alias RECT*PRECT, LPRECT, PRECTL, LPRECTL;
alias CPtr!(RECT) LPCRECT, LPCRECTL;

struct POINT
{
	LONG x;
	LONG y;
	alias x e1;
	alias y e2;
}
alias POINT POINTL;
alias POINT*PPOINT, LPPOINT, PPOINTL, LPPOINTL;

struct SIZE
{
	LONG cx;
	LONG cy;
}
alias SIZE SIZEL;
alias SIZE*PSIZE, LPSIZE, PSIZEL, LPSIZEL;

struct POINTS
{
	SHORT x;
	SHORT y;
}
alias POINTS*PPOINTS, LPPOINTS;

enum : BOOL {
	FALSE = 0,
	TRUE  = 1
}