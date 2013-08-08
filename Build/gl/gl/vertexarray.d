module gl.gl.vertexarray;
import gl.gl.context;
import gl.gl.vertexbuffer;
import gl.platform;
import derelict.opengl3.gl3;

class VertexArray {
	private {
		GLuint obj;
	}

	this() {
		glGenVertexArrays(1, &obj);
	}

	~this() {
		glDeleteVertexArrays(1, &obj);
	}

	public {
		@property uint id() {
			return obj;
		}

		void bindAttribute(Attribute attribute, ref VertexBuffer buffer, type_t type, uint count, uint stride = 0, int* offset = null) {
			glBindVertexArray(obj);
			glBindBuffer(GL_ARRAY_BUFFER, buffer.id);
			glEnableVertexAttribArray(attribute);
			glVertexAttribPointer(attribute, count, type, GL_FALSE, stride, offset);
		}

		void bindElements(ref VertexBuffer elements) {
			glBindVertexArray(obj);
			glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, elements.id);
		}
	}
}