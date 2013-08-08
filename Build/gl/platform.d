module gl.platform;
public import derelict.opengl3.gl3;

version(Posix) {
	pragma(lib, "dl");
	pragma(lib, "X11");
	pragma(lib, "Xrandr");

	public import derelict.opengl3.glx;
	public import derelict.opengl3.glxext;
	public import core.sys.posix.sys.time;
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