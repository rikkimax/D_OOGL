module gl.oogl;

public import derelict.opengl3.gl3;

public import gl.platform;

public import gl.math.vec2;
public import gl.math.vec3;
public import gl.math.vec4;
public import gl.math.mat3; // TODO clean up
public import gl.math.mat4; // TODO clean up
public import gl.math.util;

public import gl.window.window;
public import gl.window.event;

//public import gl.gl.extensions;
public import gl.gl.context;
public import gl.gl.shader;
public import gl.gl.program;
public import gl.gl.vertexbuffer;
public import gl.gl.vertexarray;
public import gl.gl.texture;
public import gl.gl.framebuffer;
public import gl.gl.transformfeedback;

public import gl.util.color;
public import gl.util.image; // TODO load images functions
public import gl.util.mesh; // TODO implementation

static this() {
	DerelictGL3.load();
	// you still need to "reload" it for it to work.
	// call this function after context is created.
	loadGL = &DerelictGL3.reload;
}

GLVersion delegate() loadGL;