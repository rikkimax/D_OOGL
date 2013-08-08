module gl.gl.program;
import gl.gl.shader;
import gl.math.vec;
import gl.math.mat;
import gl.platform;

class LinkException : Exception {
	this(string reason, string file = __FILE__, size_t line = __LINE__, Throwable next = null) {
		super(reason, file, line, next);
	}
}

class Program {
	private {
		uint obj;
	}

	this() {
		obj = glCreateProgram();
	}

	this(ref Shader vertex, Shader fragment = null, Shader geometry = null) {
		obj = glCreateProgram();
		attach(vertex);
		if (fragment !is null) 
			attach(fragment);
		if (geometry !is null)
			attach(geometry);
		link();
		glUseProgram(obj);
	}

	~this() {
		glDeleteProgram(obj);
	}

	ref Program opOpAssign(string s)(ref Program other) {
		if (s == "=") {
			gc.copy(other.obj, obj, true);
		}
		return this;
	}

	public {
		@property uint id() {
			return obj;
		}

		void attach(ref Shader shader) {
			glAttachShader(obj, shader.id);
		}

		void transformFeedbackVaryings(string[] varyings)
		in {
			assert(varyings.length > 0);
		} body {
			const(char*) varyingsPtr = varyings[0].ptr;
			glTransformFeedbackVaryings(obj, cast(int)varyings.length, &varyingsPtr, GL_INTERLEAVED_ATTRIBS);
		}

		void link() {
			int res;

			glLinkProgram(obj);
			glGetProgramiv(obj, GL_LINK_STATUS, &res);

			if (res == GL_FALSE)
				throw new LinkException(getInfoLog());
		}

		string getInfoLog() {
			int res;
			glGetProgramiv(obj, GL_INFO_LOG_LENGTH, &res);

			if (res > 0) {
				string infoLog;
				glGetProgramInfoLog(obj, res, &res, cast(char*)infoLog.ptr);
				return infoLog;
			} else {
				return "";
			}
		}

		Attribute getAttribute(string name) {
			return glGetAttribLocation(obj, (name ~ '\0').ptr);
		}

		Uniform getUniform(string name) {
			return glGetUniformLocation(obj, (name ~ '\0').ptr);
		}

		void setUniform(Uniform uniform, bool value) {
			glUniform1i(uniform, value);
		}

		void setUniform(Uniform uniform, int value) {
			glUniform1i(uniform, value);
		}

		void setUniform(Uniform uniform, float value) {
			glUniform1f(uniform, value);
		}

		void setUniform(Uniform uniform, ref Vec2 value) {
			glUniform2f(uniform, value.x, value.y);
		}

		void setUniform(Uniform uniform, ref Vec3 value) {
			glUniform3f(uniform, value.x, value.y, value.z);
		}

		void setUniform(Uniform uniform, ref Vec4 value) {
			glUniform4f(uniform, value.x, value.y, value.z, value.w);
		}

		void setUniform(Uniform uniform, int[] values) {
			glUniform1iv(uniform, cast(uint)values.length, &cast(const)values[0]);
		}

		void setUniform(Uniform uniform, float[] values) {
			glUniform1fv(uniform, cast(uint)values.length, &cast(const)values[0]);
		}

		void setUniform(Uniform uniform, Vec2[] values) {
			glUniform2fv(uniform, cast(uint)values.length, cast(float*)values.ptr);
		}

		void setUniform(Uniform uniform, Vec3[] values) {
			glUniform3fv(uniform, cast(uint)values.length, cast(float*)values.ptr);
		}

		void setUniform(Uniform uniform, Vec4[] values) {
			glUniform4fv(uniform, cast(uint)values.length, cast(float*)values.ptr);
		}

		void setUniform(Uniform uniform, ref Mat3 value) {
			glUniformMatrix3fv(uniform, 1, GL_FALSE, value.values.ptr);
		}

		void setUniform(Uniform uniform, ref Mat4 value) {
			glUniformMatrix4fv(uniform, 1, GL_FALSE, value.values.ptr);
		}
	}
}