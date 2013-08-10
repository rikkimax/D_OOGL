module gl.platform;
public import derelict.opengl3.gl3;

version(Posix) {
	pragma(lib, "dl");
	pragma(lib, "X11");
	pragma(lib, "Xrandr");

	public import derelict.opengl3.glx;
	public import derelict.opengl3.glxext;
	public import core.sys.posix.sys.time;
} else version(Windows) {
	pragma(lib, "gdi32.lib");
	pragma(lib, "user32.lib");

	public import derelict.opengl3.wgl;
	public import derelict.opengl3.wglext;
	public import win32.wingdi;
	public import win32.basetsd;
	public import win32.winuser;
	public import win32.windef;
	public import win32.winnt;
	public import win32.winbase;

	// this symbol went missing so ehh
	extern(Windows) SHORT GET_WHEEL_DELTA_WPARAM(WPARAM wparam)
	{
		return cast(SHORT) HIWORD(wparam);
	}
}

enum type_t {
	Byte = GL_BYTE,
	UnsignedByte = GL_UNSIGNED_BYTE,
	Short = GL_SHORT,
	UnsignedShort = GL_UNSIGNED_SHORT,
	Int = GL_INT,
	UnsignedInt = GL_UNSIGNED_INT,
	Float = GL_FLOAT,
	Double = GL_DOUBLE
}
alias type_t Type;

alias GLint Attribute;
alias GLint Uniform;