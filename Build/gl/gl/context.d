module gl.gl.context;
import gl.gl.program;
import gl.gl.texture;
import gl.gl.vertexarray;
import gl.gl.framebuffer;
import gl.gl.transformfeedback;

import gl.util.color;

import gl.platform;

import derelict.opengl3.arb;

version(Posix) {
	public import gl.gl.context_x11;
	import deimos.X11.Xlib;
	alias X11Context Context;
} else version(Windows) {
	public import gl.gl.context_win;
	alias WinContext Context;
}

enum buffer_t {
	Color = GL_COLOR_BUFFER_BIT,
	Depth = GL_DEPTH_BUFFER_BIT,
	Stencil = GL_STENCIL_BUFFER_BIT
}
alias buffer_t Buffer;

enum primitive_t {
	Triangles = GL_TRIANGLES,
	Lines = GL_LINES,
	Points = GL_POINTS
}
alias primitive_t Primitive;

enum capability_t {
	DepthTest = GL_DEPTH_TEST,
	StencilTest = GL_STENCIL_TEST,
	CullFace = GL_CULL_FACE,
	RasterizerDiscard = GL_RASTERIZER_DISCARD
}
alias capability_t Capability;

enum test_function_t {
	Never = GL_NEVER,
	Less = GL_LESS,
	LessEqual = GL_LEQUAL,
	Greater = GL_GREATER,
	GreaterEqual = GL_GEQUAL,
	Equal = GL_EQUAL,
	NotEqual = GL_NOTEQUAL,
	Always = GL_ALWAYS
}
alias test_function_t TestFunction;

enum stencil_action_t {
	Keep = GL_KEEP,
	Zero = GL_ZERO,
	Replace = GL_REPLACE,
	Increase = GL_INCR,
	IncreaseWrap = GL_INCR_WRAP,
	Decrease = GL_DECR,
	DecreaseWrap = GL_DECR_WRAP,
	Invert = GL_INVERT
}
alias stencil_action_t StencilAction;

class VersionException : Exception {
	this(string file = __FILE__, size_t line = __LINE__, Throwable next = null) {
		super("OpenGL 3.2+ not supported!", file, line, next);
	}
}

class PixelFormatException : Exception {
	this(string file = __FILE__, size_t line = __LINE__, Throwable next = null) {
		super("No pixel format could be found with support for the specified buffer depths and anti-aliasing.", file, line, next);
	}
}

abstract class ContextDef {
	public {
		void activate();

		void enable(capability_t capability) {
			glEnable(capability);
		}

		void disable(capability_t capability) {
			glDisable(capability);
		}

		void clearColor(Color col) {
			glClearColor(col.r / 255.0f, col.g / 255.0f, col.b / 255.0f, col.a / 255.0f);
		}

		void clear(buffer_t buffers = buffer_t.Color | buffer_t.Depth) {
			glClear(buffers);
		}

		void depthMask(bool writeEnabled) {
			glDepthMask(writeEnabled ? GL_TRUE : GL_FALSE);
		}

		void stencilMask(bool writeEnabled) {
			glStencilMask(writeEnabled ? ~0 : 0);
		}

		void stencilMask(uint mask) {
			glStencilMask(mask);
		}

		void stencilFunc(test_function_t func, int reference, uint mask = 0) {
			glStencilFunc(func, reference, mask);
		}

		void stencilOp(stencil_action_t fail, stencil_action_t zfail, stencil_action_t pass) {
			glStencilOp(fail, zfail, pass);
		}

		void useProgram(Program program) {
			if (program is null)
				glUseProgram(0);
			else
				glUseProgram(program.id);
		}

		void bindTexture(ref Texture texture, ubyte unit) {
			glActiveTexture(GL_TEXTURE0 + unit);
			glBindTexture(GL_TEXTURE_2D, texture.id);
		}

		void bindFramebuffer(ref Framebuffer frameBuffer) {
			glBindFramebuffer(GL_DRAW_FRAMEBUFFER, frameBuffer.id);

			GLint obj, width, height;
			glGetFramebufferAttachmentParameteriv(GL_DRAW_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME, &obj);

			GLint res;
			glGetIntegerv(GL_TEXTURE_BINDING_2D, &res);
			glBindTexture(GL_TEXTURE_2D, obj);
			glGetTexLevelParameteriv(GL_TEXTURE_2D, 0, GL_TEXTURE_WIDTH, &width);
			glGetTexLevelParameteriv(GL_TEXTURE_2D, 0, GL_TEXTURE_HEIGHT, &height);
			glBindTexture(GL_TEXTURE_2D, res);

			glViewport(0, 0, width, height);
		}

		void bindFramebuffer() {
			glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);

			glViewport(defaultViewport[0], defaultViewport[1], defaultViewport[2], defaultViewport[3]);
		}

		void beginTransformFeedback(TransformFeedback tf, primitive_t mode) {
			glBindTransformFeedback(GL_TRANSFORM_FEEDBACK, tf.id);
			glBeginTransformFeedback(mode);
		}

		void endTransformFeedback() {
			glEndTransformFeedback();
		}

		void drawArrays(ref VertexArray vao, primitive_t mode, uint offset, uint vertices) {
			glBindVertexArray(vao.id);
			glDrawArrays(mode, offset, vertices);
		}

		void drawElements(ref VertexArray vao, primitive_t mode, uint* offset, uint count, uint type) {
			glBindVertexArray(vao.id);
			glDrawElements(cast(uint)mode, count, type, offset);
		}

		float time();

		void setVerticalSync(bool enabled);
	}

	this() {}

	version(Windows) {
		this(ubyte color, ubyte depth, ubyte stencil, uint antialias, HDC dc) {}
	}

	version(Posix) {
		this(ubyte color, ubyte depth, ubyte stencil, uint antialias, Display* display, int screen, GLXWindow window) {}
	}

	protected {
		bool owned;
		GLint[4] defaultViewport;

		version(Windows) {
			HDC dc;
			HGLRC context;
			
			LARGE_INTEGER timeOffset;
		}

		version(Posix) {
			GLXWindow glxWindow;
			GLXContext context;
			Display* display;
			
			timeval timeOffset;
		}
	}
}