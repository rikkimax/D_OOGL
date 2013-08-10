module win32.winnt;
import win32.basetsd;

alias void   VOID;
alias char   CHAR, CCHAR;
alias wchar  WCHAR;
alias bool   BOOLEAN;
alias byte   FCHAR;
alias ubyte  UCHAR;
alias short  SHORT;
alias ushort LANGID, FSHORT;
alias uint   LCID, FLONG, ACCESS_MASK;
alias long   LONGLONG, USN;
alias ulong  DWORDLONG, ULONGLONG;

alias void*  PVOID, LPVOID;
alias char*  PSZ, PCHAR, PCCHAR, LPCH, PCH, LPSTR, PSTR;
alias wchar* PWCHAR, LPWCH, PWCH, LPWSTR, PWSTR;
alias bool*  PBOOLEAN;
alias ubyte* PUCHAR;
alias short* PSHORT;
alias int*   PLONG;
alias uint*  PLCID, PACCESS_MASK;
alias long*  PLONGLONG;
alias ulong* PDWORDLONG, PULONGLONG;

union LARGE_INTEGER {
	struct {
		uint LowPart;
		int  HighPart;
	}
	long QuadPart;
}
alias LARGE_INTEGER* PLARGE_INTEGER;

union ULARGE_INTEGER {
	struct {
		uint LowPart;
		uint HighPart;
	}
	ulong QuadPart;
}
alias ULARGE_INTEGER* PULARGE_INTEGER;

alias CPtr!(char)  LPCCH, PCSTR, LPCSTR;
alias CPtr!(wchar) LPCWCH, PCWCH, LPCWSTR, PCWSTR;

alias CHAR TCHAR, _TCHAR;

alias TCHAR        TBYTE;
alias TCHAR*       PTCH, PTBYTE, LPTCH, PTSTR, LPTSTR, LP, PTCHAR;
alias CPtr!(TCHAR) LPCTSTR;