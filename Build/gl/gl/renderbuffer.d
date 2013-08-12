module gl.gl.renderbuffer;
import gl.gl.texture;

import derelict.opengl3.gl3;

class RenderBuffer {
	private {
		uint obj;
	}

	this() {
		glGenRenderbuffers(1, &obj);
	}

	this(uint width, uint height, InternalFormat format) {
		glGenRenderbuffers(1, &obj);
		storage(width, height, format);
	}

	~this() {
		glDeleteRenderbuffers(1, &obj);
	}

	void storage(uint width, uint height, InternalFormat format) {
		glBindRenderbuffer(GL_RENDERBUFFER, obj);
		glRenderbufferStorage(GL_RENDERBUFFER, format, width, height);
	}
}