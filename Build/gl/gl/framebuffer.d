module gl.gl.framebuffer;
import gl.gl.texture;
import gl.platform;
import derelict.opengl3.gl3;

class FramebufferException : Exception {
	this(string file = __FILE__, size_t line = __LINE__, Throwable next = null) {
		super("Framebuffer could not be created!", file, line, next);
	}
}

class Framebuffer {
	private {
		uint obj;
		Texture texColor;
		Texture texDepth;
	}

	this(uint width, uint height, ubyte color = 32, ubyte depth = 24) {
		int restoreId;
		glGetIntegerv(GL_DRAW_FRAMEBUFFER_BINDING, &restoreId);


		internal_format_t colorFormat;
		if (color == 24)
			colorFormat = internal_format_t.RGB;
		else if (color == 32)
			colorFormat = internal_format_t.RGBA;
		else
			throw new FramebufferException();

		internal_format_t depthFormat;
		if (depth == 8)
			depthFormat = internal_format_t.DepthComponent;
		else if (depth == 16)
			depthFormat = internal_format_t.DepthComponent16;
		else if (depth == 24)
			depthFormat = internal_format_t.DepthComponent24;
		else if (depth == 32)
			depthFormat = internal_format_t.DepthComponent32F;
		else
			throw new FramebufferException();

		glGenFramebuffers(1, &obj);
		glBindFramebuffer(GL_DRAW_FRAMEBUFFER, obj);

		texColor.image2D(cast(void*)null, data_type_t.UnsignedByte, format_t.RGBA, width, height, colorFormat);
		texColor.setWrapping(wrapping_t.ClampEdge, wrapping_t.ClampEdge);
		glFramebufferTexture2D(GL_DRAW_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, texColor.id, 0);

		if (depth > 0) {
			glBindTexture(GL_TEXTURE_2D, texDepth.id);
			glTexImage2D(GL_TEXTURE_2D, 0, depthFormat, width, height, 0, GL_DEPTH_COMPONENT, GL_UNSIGNED_BYTE, cast(void*)null);
			texDepth.setWrapping(wrapping_t.ClampEdge, wrapping_t.ClampEdge);
			texDepth.setFilters(filter_t.Nearest, filter_t.Nearest);
			glFramebufferTexture2D(GL_DRAW_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_TEXTURE_2D, texDepth.id, 0);
		}

		if (glCheckFramebufferStatus(GL_DRAW_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
			throw new FramebufferException();

		glBindFramebuffer(GL_DRAW_FRAMEBUFFER, restoreId);
	}

	~this() {
		glDeleteFramebuffers(1, &obj);
	}

	public {
		@property uint id() {
			return obj;
		}

		ref Texture getTexture() {
			return texColor;
		}

		ref Texture getDepthTexture() {
			return texDepth;
		}
	}
}