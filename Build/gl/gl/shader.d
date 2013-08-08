module gl.gl.shader;
import gl.platform;

pure string GLSL(string x) {
	return "#version 400\n" ~ x ~ "\0";
}

enum shader_type_t {
	Vertex = GL_VERTEX_SHADER,
	Fragment = GL_FRAGMENT_SHADER,
	Geometry = GL_GEOMETRY_SHADER
}

alias shader_type_t ShaderType;

class CompileException : Exception {
	this(string reason, string file = __FILE__, size_t line = __LINE__, Throwable next = null) {
		super(reason, file, line, next);
	}
}

class Shader {
	private {
		uint obj;
	}

	this(shader_type_t shader, string code = null) {
		obj = glCreateShader(shader);
		if (code !is null) {
			source(code);
			compile();
		}
	}

	~this() {
		glDeleteShader(obj);
	}

	ref Shader opOpAssign(string s)(ref Shader other) {
		if (s == "=") {
			gc.copy(other.obj, obj, true);
		}
		return this;
	}

	public {
		@property uint id() {
			return obj;
		}

		void source(string code) {
			const(char*) codePtr = code.ptr;
			glShaderSource(obj, 1, &codePtr, null);
		}

		void compile() {
			GLint res;

			glCompileShader(obj);
			glGetShaderiv(obj, GL_COMPILE_STATUS, &res);

			if (res == GL_FALSE)
				throw new CompileException(getInfoLog());
		}

		string getInfoLog() {
			GLint res;
			glGetShaderiv(obj, GL_INFO_LOG_LENGTH, &res);

			if (res > 0) {
				char* infoLog;
				glGetShaderInfoLog(obj, res, &res, infoLog);
				return *(cast(string*)infoLog);
			}
			return "";
		}
	}
}