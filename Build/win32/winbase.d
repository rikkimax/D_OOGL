module win32.winbase;
import win32.windef;
import win32.winnt;

extern(System):
	BOOL QueryPerformanceCounter(PLARGE_INTEGER);
	BOOL QueryPerformanceFrequency(PLARGE_INTEGER);

	HMODULE GetModuleHandleA(LPCSTR);
	HMODULE GetModuleHandleW(LPCWSTR);