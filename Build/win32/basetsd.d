module win32.basetsd;

template CPtr(T) {
	version (D_Version2) {
		// must use mixin so that it doesn't cause a syntax error under D1
		mixin("alias const(T)* CPtr;");
	} else {
		alias T* CPtr;
	}
}

alias void* HANDLE;

alias HANDLE* PHANDLE, LPHANDLE;

version (Win64) {
	alias long __int3264;
	const ulong ADDRESS_TAG_BIT = 0x40000000000;
	
	alias long INT_PTR, LONG_PTR;
	alias long* PINT_PTR, PLONG_PTR;
	alias ulong UINT_PTR, ULONG_PTR, HANDLE_PTR;
	alias ulong* PUINT_PTR, PULONG_PTR;
	alias int HALF_PTR;
	alias int* PHALF_PTR;
	alias uint UHALF_PTR;
	alias uint* PUHALF_PTR;
} else {
	alias int __int3264;
	const uint ADDRESS_TAG_BIT = 0x80000000;
	
	alias int INT_PTR, LONG_PTR;
	alias int* PINT_PTR, PLONG_PTR;
	alias uint UINT_PTR, ULONG_PTR, HANDLE_PTR;
	alias uint* PUINT_PTR, PULONG_PTR;
	alias short HALF_PTR;
	alias short* PHALF_PTR;
	alias ushort UHALF_PTR;
	alias ushort* PUHALF_PTR;
}