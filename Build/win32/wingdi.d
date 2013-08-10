module win32.wingdi;
import win32.basetsd;
import win32.windef;
import win32.winnt;

const DWORD
	PFD_DOUBLEBUFFER = 0x00000001,
	PFD_STEREO = 0x00000002,
	PFD_DRAW_TO_WINDOW      = 0x00000004,
	PFD_DRAW_TO_BITMAP      = 0x00000008,
	PFD_SUPPORT_GDI         = 0x00000010,
	PFD_SUPPORT_OPENGL      = 0x00000020,
	PFD_GENERIC_FORMAT      = 0x00000040,
	PFD_NEED_PALETTE        = 0x00000080,
	PFD_NEED_SYSTEM_PALETTE = 0x00000100,
	PFD_SWAP_EXCHANGE       = 0x00000200,
	PFD_SWAP_COPY           = 0x00000400,
	PFD_SWAP_LAYER_BUFFERS  = 0x00000800,
	PFD_GENERIC_ACCELERATED = 0x00001000,
	PFD_SUPPORT_DIRECTDRAW  = 0x00002000,
	
	/* PIXELFORMATDESCRIPTOR flags for use in ChoosePixelFormat only */
	PFD_DEPTH_DONTCARE        = 0x20000000,
	PFD_DOUBLEBUFFER_DONTCARE = 0x40000000,
	PFD_STEREO_DONTCARE       = 0x80000000;

enum : BYTE {
	PFD_TYPE_RGBA       = 0,
	PFD_TYPE_COLORINDEX = 1
}

const byte
	PFD_MAIN_PLANE     = 0,
	PFD_OVERLAY_PLANE  = 1,
	PFD_UNDERLAY_PLANE = -1;

struct PIXELFORMATDESCRIPTOR
{
	WORD nSize;
	WORD nVersion;
	DWORD dwFlags;
	BYTE iPixelType;
	BYTE cColorBits;
	BYTE cRedBits;
	BYTE cRedShift;
	BYTE cGreenBits;
	BYTE cGreenShift;
	BYTE cBlueBits;
	BYTE cBlueShift;
	BYTE cAlphaBits;
	BYTE cAlphaShift;
	BYTE cAccumBits;
	BYTE cAccumRedBits;
	BYTE cAccumGreenBits;
	BYTE cAccumBlueBits;
	BYTE cAccumAlphaBits;
	BYTE cDepthBits;
	BYTE cStencilBits;
	BYTE cAuxBuffers;
	BYTE iLayerType;
	BYTE bReserved;
	DWORD dwLayerMask;
	DWORD dwVisibleMask;
	DWORD dwDamageMask;
}
alias PIXELFORMATDESCRIPTOR*PPIXELFORMATDESCRIPTOR, LPPIXELFORMATDESCRIPTOR;

extern(System):

enum : int {
	WHITE_BRUSH = 0,
	LTGRAY_BRUSH,
	GRAY_BRUSH,
	DKGRAY_BRUSH,
	BLACK_BRUSH,
	HOLLOW_BRUSH,     // = 5
	NULL_BRUSH = HOLLOW_BRUSH,
	WHITE_PEN  = 6,
	BLACK_PEN,
	NULL_PEN,     // = 8
	OEM_FIXED_FONT = 10,
	ANSI_FIXED_FONT,
	ANSI_VAR_FONT,
	SYSTEM_FONT,
	DEVICE_DEFAULT_FONT,
	DEFAULT_PALETTE,
	SYSTEM_FIXED_FONT,
}

struct DEVMODEA
{
	BYTE[CCHDEVICENAME] dmDeviceName;
	WORD dmSpecVersion;
	WORD dmDriverVersion;
	WORD dmSize;
	WORD dmDriverExtra;
	DWORD dmFields;
	union {
		struct
		{
			short dmOrientation;
			short dmPaperSize;
			short dmPaperLength;
			short dmPaperWidth;
			short dmScale;
			short dmCopies;
			short dmDefaultSource;
			short dmPrintQuality;
		}
		POINTL dmPosition;
		DWORD dmDisplayOrientation;
		DWORD dmDisplayFixedOutput;
	}
	short dmColor;
	short dmDuplex;
	short dmYResolution;
	short dmTTOption;
	short dmCollate;
	BYTE[CCHFORMNAME]   dmFormName;
	WORD dmLogPixels;
	DWORD dmBitsPerPel;
	DWORD dmPelsWidth;
	DWORD dmPelsHeight;
	union {
		DWORD dmDisplayFlags;
		DWORD dmNup;
	}
	DWORD dmDisplayFrequency;
}
alias DEVMODEA*PDEVMODEA, NPDEVMODEA, LPDEVMODEA;

const CCHDEVICENAME = 32;
const CCHFORMNAME   = 32;

const DWORD
	DM_COPIES = 0x00000100,
	DM_DEFAULTSOURCE    = 0x00000200,
	DM_PRINTQUALITY     = 0x00000400,
	DM_COLOR            = 0x00000800,
	DM_DUPLEX           = 0x00001000,
	DM_YRESOLUTION      = 0x00002000,
	DM_TTOPTION         = 0x00004000,
	DM_COLLATE          = 0x00008000,
	DM_FORMNAME         = 0x00010000,
	DM_LOGPIXELS        = 0x00020000,
	DM_BITSPERPEL       = 0x00040000,
	DM_PELSWIDTH        = 0x00080000,
	DM_PELSHEIGHT       = 0x00100000,
	DM_DISPLAYFLAGS     = 0x00200000,
	DM_DISPLAYFREQUENCY = 0x00400000;

DWORD SetMapperFlags(HDC, DWORD);

HMETAFILE SetMetaFileBitsEx(UINT, CPtr!(BYTE));

int SetMetaRgn(HDC);

BOOL SetMiterLimit(HDC, FLOAT, PFLOAT);

//UINT SetPaletteEntries(HPALETTE, UINT, UINT, CPtr!(PALETTEENTRY));

COLORREF SetPixel(HDC, int, int, COLORREF);

BOOL SetPixelFormat(HDC, int, CPtr!(PIXELFORMATDESCRIPTOR));

BOOL SetPixelV(HDC, int, int, COLORREF);

int SetPolyFillMode(HDC, int);

BOOL SetRectRgn(HRGN, int, int, int, int);

int SetROP2(HDC, int);

int SetStretchBltMode(HDC, int);

UINT SetSystemPaletteUse(HDC, UINT);

UINT SetTextAlign(HDC, UINT);

int SetTextCharacterExtra(HDC, int);

COLORREF SetTextColor(HDC, COLORREF);

BOOL SetTextJustification(HDC, int, int);

BOOL SetViewportExtEx(HDC, int, int, LPSIZE);

BOOL SetViewportOrgEx(HDC, int, int, LPPOINT);

BOOL SetWindowExtEx(HDC, int, int, LPSIZE);

BOOL SetWindowOrgEx(HDC, int, int, LPPOINT);

//HENHMETAFILE SetWinMetaFileBits(UINT, CPtr!(BYTE), HDC, CPtr!(METAFILEPICT));

//BOOL SetWorldTransform(HDC, CPtr!(XFORM));

//int StartDocA(HDC, CPtr!(DOCINFOA));

//int StartDocW(HDC, CPtr!(DOCINFOW));

int StartPage(HDC);

BOOL StretchBlt(HDC, int, int, int, int, HDC, int, int, int, int, DWORD);

//int StretchDIBits(HDC, int, int, int, int, int, int, int, int, CPtr!(VOID), CPtr!(BITMAPINFO), UINT, DWORD);

BOOL StrokeAndFillPath(HDC);

BOOL StrokePath(HDC);

BOOL SwapBuffers(HDC);

//BOOL TextOutA(HDC, int, int, LPCSTR, int);

//BOOL TextOutW(HDC, int, int, LPCWSTR, int);

//BOOL TranslateCharsetInfo(PDWORD, LPCHARSETINFO, DWORD);

BOOL UnrealizeObject(HGDIOBJ);

BOOL UpdateColors(HDC);

//BOOL UpdateICMRegKeyA(DWORD, DWORD, LPSTR, UINT);

//BOOL UpdateICMRegKeyW(DWORD, DWORD, LPWSTR, UINT);

BOOL WidenPath(HDC);

BOOL wglCopyContext(HGLRC, HGLRC, UINT);

HGLRC wglCreateContext(HDC);

HGLRC wglCreateLayerContext(HDC, int);

BOOL wglDeleteContext(HGLRC);

//BOOL wglDescribeLayerPlane(HDC, int, int, UINT, LPLAYERPLANEDESCRIPTOR);

HGLRC wglGetCurrentContext();

HDC wglGetCurrentDC();

int wglGetLayerPaletteEntries(HDC, int, int, int, COLORREF*);

//PROC wglGetProcAddress(LPCSTR);

BOOL wglMakeCurrent(HDC, HGLRC);

BOOL wglRealizeLayerPalette(HDC, int, BOOL);

int wglSetLayerPaletteEntries(HDC, int, int, int, CPtr!(COLORREF));

BOOL wglShareLists(HGLRC, HGLRC);

BOOL wglSwapLayerBuffers(HDC, UINT);

BOOL wglUseFontBitmapsA(HDC, DWORD, DWORD, DWORD);

BOOL wglUseFontBitmapsW(HDC, DWORD, DWORD, DWORD);

//BOOL wglUseFontOutlinesA(HDC, DWORD, DWORD, DWORD, FLOAT, FLOAT, int, LPGLYPHMETRICSFLOAT);

//BOOL wglUseFontOutlinesW(HDC, DWORD, DWORD, DWORD, FLOAT, FLOAT, int, LPGLYPHMETRICSFLOAT);

int AbortDoc(HDC);

BOOL AbortPath(HDC);

int AddFontResourceA(LPCSTR);

int AddFontResourceW(LPCWSTR);

BOOL AngleArc(HDC, int, int, DWORD, FLOAT, FLOAT);

//BOOL AnimatePalette(HPALETTE, UINT, UINT, CPtr!(PALETTEENTRY));

BOOL Arc(HDC, int, int, int, int, int, int, int, int);

BOOL ArcTo(HDC, int, int, int, int, int, int, int, int);

BOOL BeginPath(HDC);

BOOL BitBlt(HDC, int, int, int, int, HDC, int, int, DWORD);

BOOL CancelDC(HDC);

BOOL CheckColorsInGamut(HDC, PVOID, PVOID, DWORD);

BOOL Chord(HDC, int, int, int, int, int, int, int, int);

int ChoosePixelFormat(HDC, CPtr!(PIXELFORMATDESCRIPTOR));

HENHMETAFILE CloseEnhMetaFile(HDC);

BOOL CloseFigure(HDC);

HMETAFILE CloseMetaFile(HDC);

BOOL ColorMatchToTarget(HDC, HDC, DWORD);

BOOL ColorCorrectPalette(HDC, HPALETTE, DWORD, DWORD);

int CombineRgn(HRGN, HRGN, HRGN, int);

//BOOL CombineTransform(LPXFORM, CPtr!(XFORM), CPtr!(XFORM));

HENHMETAFILE CopyEnhMetaFileA(HENHMETAFILE, LPCSTR);

HENHMETAFILE CopyEnhMetaFileW(HENHMETAFILE, LPCWSTR);

HMETAFILE CopyMetaFileA(HMETAFILE, LPCSTR);

HMETAFILE CopyMetaFileW(HMETAFILE, LPCWSTR);

HBITMAP CreateBitmap(int, int, UINT, UINT, PCVOID);

//HBITMAP CreateBitmapIndirect(CPtr!(BITMAP));

//HBRUSH CreateBrushIndirect(CPtr!(LOGBRUSH));

//HCOLORSPACE CreateColorSpaceA(LPLOGCOLORSPACEA);

//HCOLORSPACE CreateColorSpaceW(LPLOGCOLORSPACEW);

HBITMAP CreateCompatibleBitmap(HDC, int, int);

HDC CreateCompatibleDC(HDC);

HDC CreateDCA(LPCSTR, LPCSTR, LPCSTR, CPtr!(DEVMODEA));

//HDC CreateDCW(LPCWSTR, LPCWSTR, LPCWSTR, CPtr!(DEVMODEW));

//HBITMAP CreateDIBitmap(HDC, CPtr!(BITMAPINFOHEADER), DWORD, PCVOID, CPtr!(BITMAPINFO), UINT);

HBRUSH CreateDIBPatternBrush(HGLOBAL, UINT);

HBRUSH CreateDIBPatternBrushPt(PCVOID, UINT);

//HBITMAP CreateDIBSection(HDC, CPtr!(BITMAPINFO), UINT, void**, HANDLE, DWORD);

HBITMAP CreateDiscardableBitmap(HDC, int, int);

HRGN CreateEllipticRgn(int, int, int, int);

HRGN CreateEllipticRgnIndirect(LPCRECT);

HDC CreateEnhMetaFileA(HDC, LPCSTR, LPCRECT, LPCSTR);

HDC CreateEnhMetaFileW(HDC, LPCWSTR, LPCRECT, LPCWSTR);

HFONT CreateFontA(int, int, int, int, int, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, LPCSTR);

HFONT CreateFontW(int, int, int, int, int, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, LPCWSTR);

//HFONT CreateFontIndirectA(CPtr!(LOGFONTA));

//HFONT CreateFontIndirectW(CPtr!(LOGFONTW));

HPALETTE CreateHalftonePalette(HDC);

HBRUSH CreateHatchBrush(int, COLORREF);

HDC CreateICA(LPCSTR, LPCSTR, LPCSTR, CPtr!(DEVMODEA));

//HDC CreateICW(LPCWSTR, LPCWSTR, LPCWSTR, CPtr!(DEVMODEW));

HDC CreateMetaFileA(LPCSTR);

HDC CreateMetaFileW(LPCWSTR);

//HPALETTE CreatePalette(CPtr!(LOGPALETTE));

HBRUSH CreatePatternBrush(HBITMAP);

HPEN CreatePen(int, int, COLORREF);

//HPEN CreatePenIndirect(CPtr!(LOGPEN));

HRGN CreatePolygonRgn(CPtr!(POINT), int, int);

HRGN CreatePolyPolygonRgn(CPtr!(POINT), CPtr!(INT), int, int);

HRGN CreateRectRgn(int, int, int, int);

HRGN CreateRectRgnIndirect(LPCRECT);

HRGN CreateRoundRectRgn(int, int, int, int, int, int);

BOOL CreateScalableFontResourceA(DWORD, LPCSTR, LPCSTR, LPCSTR);

BOOL CreateScalableFontResourceW(DWORD, LPCWSTR, LPCWSTR, LPCWSTR);

HBRUSH CreateSolidBrush(COLORREF);

BOOL DeleteColorSpace(HCOLORSPACE);

BOOL DeleteDC(HDC);

BOOL DeleteEnhMetaFile(HENHMETAFILE);

BOOL DeleteMetaFile(HMETAFILE);

BOOL DeleteObject(HGDIOBJ);

int DescribePixelFormat(HDC, int, UINT, LPPIXELFORMATDESCRIPTOR);

DWORD DeviceCapabilitiesA(LPCSTR, LPCSTR, WORD, LPSTR, CPtr!(DEVMODEA));

//DWORD DeviceCapabilitiesW(LPCWSTR, LPCWSTR, WORD, LPWSTR, CPtr!(DEVMODEW));

BOOL DPtoLP(HDC, LPPOINT, int);

int DrawEscape(HDC, int, int, LPCSTR);

BOOL Ellipse(HDC, int, int, int, int);

int EndDoc(HDC);

int EndPage(HDC);

BOOL EndPath(HDC);

//BOOL EnumEnhMetaFile(HDC, HENHMETAFILE, ENHMFENUMPROC, PVOID, LPCRECT);

//int EnumFontFamiliesA(HDC, LPCSTR, FONTENUMPROCA, LPARAM);

//int EnumFontFamiliesW(HDC, LPCWSTR, FONTENUMPROCW, LPARAM);

//int EnumFontFamiliesExA(HDC, PLOGFONTA, FONTENUMPROCA, LPARAM, DWORD);

//int EnumFontFamiliesExW(HDC, PLOGFONTW, FONTENUMPROCW, LPARAM, DWORD);

//int EnumFontsA(HDC, LPCSTR, FONTENUMPROCA, LPARAM);

//int EnumFontsW(HDC, LPCWSTR, FONTENUMPROCW, LPARAM);

//int EnumICMProfilesA(HDC, ICMENUMPROCA, LPARAM);

//int EnumICMProfilesW(HDC, ICMENUMPROCW, LPARAM);

//BOOL EnumMetaFile(HDC, HMETAFILE, MFENUMPROC, LPARAM);

//int EnumObjects(HDC, int, GOBJENUMPROC, LPARAM);

BOOL EqualRgn(HRGN, HRGN);

int Escape(HDC, int, int, LPCSTR, PVOID);

int ExcludeClipRect(HDC, int, int, int, int);

int ExcludeUpdateRgn(HDC, HWND);

//HPEN ExtCreatePen(DWORD, DWORD, CPtr!(LOGBRUSH), DWORD, CPtr!(DWORD));

//HRGN ExtCreateRegion(CPtr!(XFORM), DWORD, CPtr!(RGNDATA));

int ExtEscape(HDC, int, int, LPCSTR, int, LPSTR);

BOOL ExtFloodFill(HDC, int, int, COLORREF, UINT);

int ExtSelectClipRgn(HDC, HRGN, int);

BOOL ExtTextOutA(HDC, int, int, UINT, LPCRECT, LPCSTR, UINT, CPtr!(INT));

BOOL ExtTextOutW(HDC, int, int, UINT, LPCRECT, LPCWSTR, UINT, CPtr!(INT));

BOOL FillPath(HDC);

int FillRect(HDC, LPCRECT, HBRUSH);

int FillRgn(HDC, HRGN, HBRUSH);

BOOL FixBrushOrgEx(HDC, int, int, LPPOINT);

BOOL FlattenPath(HDC);

BOOL FloodFill(HDC, int, int, COLORREF);

BOOL FrameRgn(HDC, HRGN, HBRUSH, int, int);

BOOL GdiComment(HDC, UINT, CPtr!(BYTE));

BOOL GdiFlush();

DWORD GdiGetBatchLimit();

DWORD GdiSetBatchLimit(DWORD);

int GetArcDirection(HDC);

BOOL GetAspectRatioFilterEx(HDC, LPSIZE);

LONG GetBitmapBits(HBITMAP, LONG, PVOID);

BOOL GetBitmapDimensionEx(HBITMAP, LPSIZE);

COLORREF GetBkColor(HDC);

int GetBkMode(HDC);

UINT GetBoundsRect(HDC, LPRECT, UINT);

BOOL GetBrushOrgEx(HDC, LPPOINT);

//BOOL GetCharABCWidthsA(HDC, UINT, UINT, LPABC);

//BOOL GetCharABCWidthsW(HDC, UINT, UINT, LPABC);

//BOOL GetCharABCWidthsFloatA(HDC, UINT, UINT, LPABCFLOAT);

//BOOL GetCharABCWidthsFloatW(HDC, UINT, UINT, LPABCFLOAT);

//DWORD GetCharacterPlacementA(HDC, LPCSTR, int, int, LPGCP_RESULTSA, DWORD);

//DWORD GetCharacterPlacementW(HDC, LPCWSTR, int, int, LPGCP_RESULTSW, DWORD);

BOOL GetCharWidth32A(HDC, UINT, UINT, LPINT);

BOOL GetCharWidth32W(HDC, UINT, UINT, LPINT);

BOOL GetCharWidthA(HDC, UINT, UINT, LPINT);

BOOL GetCharWidthW(HDC, UINT, UINT, LPINT);

BOOL GetCharWidthFloatA(HDC, UINT, UINT, PFLOAT);

BOOL GetCharWidthFloatW(HDC, UINT, UINT, PFLOAT);

int GetClipBox(HDC, LPRECT);

int GetClipRgn(HDC, HRGN);

//BOOL GetColorAdjustment(HDC, LPCOLORADJUSTMENT);

HANDLE GetColorSpace(HDC);

HGDIOBJ GetCurrentObject(HDC, UINT);

BOOL GetCurrentPositionEx(HDC, LPPOINT);

HCURSOR GetCursor();

BOOL GetDCOrgEx(HDC, LPPOINT);

int GetDeviceCaps(HDC, int);

BOOL GetDeviceGammaRamp(HDC, PVOID);

//UINT GetDIBColorTable(HDC, UINT, UINT, RGBQUAD*);

//int GetDIBits(HDC, HBITMAP, UINT, UINT, PVOID, LPBITMAPINFO, UINT);

HENHMETAFILE GetEnhMetaFileA(LPCSTR);

HENHMETAFILE GetEnhMetaFileW(LPCWSTR);

UINT GetEnhMetaFileBits(HENHMETAFILE, UINT, LPBYTE);

UINT GetEnhMetaFileDescriptionA(HENHMETAFILE, UINT, LPSTR);

UINT GetEnhMetaFileDescriptionW(HENHMETAFILE, UINT, LPWSTR);

//UINT GetEnhMetaFileHeader(HENHMETAFILE, UINT, LPENHMETAHEADER);

//UINT GetEnhMetaFilePaletteEntries(HENHMETAFILE, UINT, LPPALETTEENTRY);

UINT GetEnhMetaFilePixelFormat(HENHMETAFILE, DWORD, CPtr!(PIXELFORMATDESCRIPTOR));

DWORD GetFontData(HDC, DWORD, DWORD, PVOID, DWORD);

DWORD GetFontLanguageInfo(HDC);

//DWORD GetGlyphOutlineA(HDC, UINT, UINT, LPGLYPHMETRICS, DWORD, PVOID, CPtr!(MAT2));

//DWORD GetGlyphOutlineW(HDC, UINT, UINT, LPGLYPHMETRICS, DWORD, PVOID, CPtr!(MAT2));

int GetGraphicsMode(HDC);

BOOL GetICMProfileA(HDC, DWORD, LPSTR);

BOOL GetICMProfileW(HDC, DWORD, LPWSTR);

//DWORD GetKerningPairsA(HDC, DWORD, LPKERNINGPAIR);

//DWORD GetKerningPairsW(HDC, DWORD, LPKERNINGPAIR);

//BOOL GetLogColorSpaceA(HCOLORSPACE, LPLOGCOLORSPACEA, DWORD);

//BOOL GetLogColorSpaceW(HCOLORSPACE, LPLOGCOLORSPACEW, DWORD);

int GetMapMode(HDC);

HMETAFILE GetMetaFileA(LPCSTR);

HMETAFILE GetMetaFileW(LPCWSTR);

UINT GetMetaFileBitsEx(HMETAFILE, UINT, PVOID);

int GetMetaRgn(HDC, HRGN);

BOOL GetMiterLimit(HDC, PFLOAT);

COLORREF GetNearestColor(HDC, COLORREF);

UINT GetNearestPaletteIndex(HPALETTE, COLORREF);

int GetObjectA(HGDIOBJ, int, PVOID);

int GetObjectW(HGDIOBJ, int, PVOID);

DWORD GetObjectType(HGDIOBJ);

//UINT GetOutlineTextMetricsA(HDC, UINT, LPOUTLINETEXTMETRICA);

//UINT GetOutlineTextMetricsW(HDC, UINT, LPOUTLINETEXTMETRICW);

//UINT GetPaletteEntries(HPALETTE, UINT, UINT, LPPALETTEENTRY);

int GetPath(HDC, LPPOINT, PBYTE, int);

COLORREF GetPixel(HDC, int, int);

int GetPixelFormat(HDC);

int GetPolyFillMode(HDC);

//BOOL GetRasterizerCaps(LPRASTERIZER_STATUS, UINT);

int GetRandomRgn(HDC, HRGN, INT);

//DWORD GetRegionData(HRGN, DWORD, LPRGNDATA);

int GetRgnBox(HRGN, LPRECT);

int GetROP2(HDC);

HGDIOBJ GetStockObject(int);

int GetStretchBltMode(HDC);

//UINT GetSystemPaletteEntries(HDC, UINT, UINT, LPPALETTEENTRY);

UINT GetSystemPaletteUse(HDC);

UINT GetTextAlign(HDC);

int GetTextCharacterExtra(HDC);

int GetTextCharset(HDC);

//int GetTextCharsetInfo(HDC, LPFONTSIGNATURE, DWORD);

COLORREF GetTextColor(HDC);

BOOL GetTextExtentExPointA(HDC, LPCSTR, int, int, LPINT, LPINT, LPSIZE);

BOOL GetTextExtentExPointW(HDC, LPCWSTR, int, int, LPINT, LPINT, LPSIZE);

BOOL GetTextExtentPointA(HDC, LPCSTR, int, LPSIZE);

BOOL GetTextExtentPointW(HDC, LPCWSTR, int, LPSIZE);

BOOL GetTextExtentPoint32A(HDC, LPCSTR, int, LPSIZE);

BOOL GetTextExtentPoint32W(HDC, LPCWSTR, int, LPSIZE);

int GetTextFaceA(HDC, int, LPSTR);

int GetTextFaceW(HDC, int, LPWSTR);

//BOOL GetTextMetricsA(HDC, LPTEXTMETRICA);

//BOOL GetTextMetricsW(HDC, LPTEXTMETRICW);

BOOL GetViewportExtEx(HDC, LPSIZE);

BOOL GetViewportOrgEx(HDC, LPPOINT);

BOOL GetWindowExtEx(HDC, LPSIZE);

BOOL GetWindowOrgEx(HDC, LPPOINT);

UINT GetWinMetaFileBits(HENHMETAFILE, UINT, LPBYTE, INT, HDC);

//BOOL GetWorldTransform(HDC, LPXFORM);

int IntersectClipRect(HDC, int, int, int, int);

BOOL InvertRgn(HDC, HRGN);

//BOOL LineDDA(int, int, int, int, LINEDDAPROC, LPARAM);

BOOL LineTo(HDC, int, int);

BOOL LPtoDP(HDC, LPPOINT, int);

BOOL MaskBlt(HDC, int, int, int, int, HDC, int, int, HBITMAP, int, int, DWORD);

//BOOL ModifyWorldTransform(HDC, CPtr!(XFORM), DWORD);

BOOL MoveToEx(HDC, int, int, LPPOINT);

int OffsetClipRgn(HDC, int, int);

int OffsetRgn(HRGN, int, int);

BOOL OffsetViewportOrgEx(HDC, int, int, LPPOINT);

BOOL OffsetWindowOrgEx(HDC, int, int, LPPOINT);

BOOL PaintRgn(HDC, HRGN);

BOOL PatBlt(HDC, int, int, int, int, DWORD);

HRGN PathToRegion(HDC);

BOOL Pie(HDC, int, int, int, int, int, int, int, int);

BOOL PlayEnhMetaFile(HDC, HENHMETAFILE, LPCRECT);

//BOOL PlayEnhMetaFileRecord(HDC, LPHANDLETABLE, CPtr!(ENHMETARECORD), UINT);

BOOL PlayMetaFile(HDC, HMETAFILE);

//BOOL PlayMetaFileRecord(HDC, LPHANDLETABLE, LPMETARECORD, UINT);

BOOL PlgBlt(HDC, CPtr!(POINT), HDC, int, int, int, int, HBITMAP, int, int);

BOOL PolyBezier(HDC, CPtr!(POINT), DWORD);

BOOL PolyBezierTo(HDC, CPtr!(POINT), DWORD);

BOOL PolyDraw(HDC, CPtr!(POINT), CPtr!(BYTE), int);

BOOL Polygon(HDC, CPtr!(POINT), int);

BOOL Polyline(HDC, CPtr!(POINT), int);

BOOL PolylineTo(HDC, CPtr!(POINT), DWORD);

BOOL PolyPolygon(HDC, CPtr!(POINT), CPtr!(INT), int);

BOOL PolyPolyline(HDC, CPtr!(POINT), CPtr!(DWORD), DWORD);

//BOOL PolyTextOutA(HDC, CPtr!(POLYTEXTA), int);

//BOOL PolyTextOutW(HDC, CPtr!(POLYTEXTW), int);

BOOL PtInRegion(HRGN, int, int);

BOOL PtVisible(HDC, int, int);

UINT RealizePalette(HDC);

BOOL Rectangle(HDC, int, int, int, int);

BOOL RectInRegion(HRGN, LPCRECT);

BOOL RectVisible(HDC, LPCRECT);

BOOL RemoveFontResourceA(LPCSTR);

BOOL RemoveFontResourceW(LPCWSTR);

HDC ResetDCA(HDC, CPtr!(DEVMODEA));

//HDC ResetDCW(HDC, CPtr!(DEVMODEW));

BOOL ResizePalette(HPALETTE, UINT);

BOOL RestoreDC(HDC, int);

BOOL RoundRect(HDC, int, int, int, int, int, int);

int SaveDC(HDC);

BOOL ScaleViewportExtEx(HDC, int, int, int, int, LPSIZE);

BOOL ScaleWindowExtEx(HDC, int, int, int, int, LPSIZE);

BOOL SelectClipPath(HDC, int);

int SelectClipRgn(HDC, HRGN);

HGDIOBJ SelectObject(HDC, HGDIOBJ);

HPALETTE SelectPalette(HDC, HPALETTE, BOOL);

//int SetAbortProc(HDC, ABORTPROC);

int SetArcDirection(HDC, int);

LONG SetBitmapBits(HBITMAP, DWORD, PCVOID);

BOOL SetBitmapDimensionEx(HBITMAP, int, int, LPSIZE);

COLORREF SetBkColor(HDC, COLORREF);

int SetBkMode(HDC, int);

UINT SetBoundsRect(HDC, LPCRECT, UINT);

BOOL SetBrushOrgEx(HDC, int, int, LPPOINT);

//BOOL SetColorAdjustment(HDC, CPtr!(COLORADJUSTMENT));

BOOL SetColorSpace(HDC, HCOLORSPACE);

BOOL SetDeviceGammaRamp(HDC, PVOID);

//UINT SetDIBColorTable(HDC, UINT, UINT, CPtr!(RGBQUAD));

//int SetDIBits(HDC, HBITMAP, UINT, UINT, PCVOID, CPtr!(BITMAPINFO), UINT);

//int SetDIBitsToDevice(HDC, int, int, DWORD, DWORD, int, int, UINT, UINT, PCVOID, CPtr!(BITMAPINFO), UINT);

HENHMETAFILE SetEnhMetaFileBits(UINT, CPtr!(BYTE));

int SetGraphicsMode(HDC, int);

int SetICMMode(HDC, int);

BOOL SetICMProfileA(HDC, LPSTR);

BOOL SetICMProfileW(HDC, LPWSTR);

int SetMapMode(HDC, int);