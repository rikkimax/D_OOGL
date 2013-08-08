module gl.gl.vertexbuffer;
import gl.gl.vertexarray;
import gl.platform : Type;

import gl.util.mesh;
import gl.math.vec2;
import gl.math.vec3;
import gl.math.vec4;
import derelict.opengl3.gl3;

enum buffer_usage_t {
	StreamDraw = GL_STREAM_DRAW,
	StreamRead = GL_STREAM_READ,
	StreamCopy = GL_STREAM_COPY,
	StaticDraw = GL_STATIC_DRAW,
	StaticRead = GL_STATIC_READ,
	StaticCopy = GL_STATIC_COPY,
	DynamicDraw = GL_DYNAMIC_DRAW,
	DynamicRead = GL_DYNAMIC_READ,
	DynamicCopy = GL_DYNAMIC_COPY
}

alias buffer_usage_t BufferUsage;

class VertexDataBuffer {
	private {
		ubyte[] data;

		void Bytes(ubyte* bytes, uint count) {
			for (uint i = 0; i < count; i++) {
				data ~= bytes[i];
			}
		}
	}

	void opOpAssign(string s)(float v) {
		if (s == "=")
			Bytes(cast(ubyte*)&v, v.sizeof);
	}

	void opOpAssign(string s)(int v) {
		if (s == "=")
			Bytes(cast(ubyte*)&v, v.sizeof);
	}

	void opOpAssign(string s)(uint v) {
		if (s == "=")
			Bytes(cast(ubyte*)&v, v.sizeof);
	}

	void opOpAssign(string s)(Vec2 v) {
		if (s == "=")
			Bytes(cast(ubyte*)&v, v.sizeof);
	}

	void opOpAssign(string s)(Vec3 v) {
		if (s == "=")
			Bytes(cast(ubyte*)&v, v.sizeof);
	}

	void opOpAssign(string s)(Vec4 v) {
		if (s == "=")
			Bytes(cast(ubyte*)&v, v.sizeof);
	}

	public {
		@property ubyte[] values() {
			return data;
		}

		@property void* pointer() {
			return data.ptr;
		}

		@property uint size() {
			return data.sizeof;
		}
	}
}

alias void function(ref Vertex, ref VertexDataBuffer) F;

class VertexBuffer {
	private {
		uint obj;
	}

	this() {
		glGenBuffers(1, &obj);
	}

	this(uint size, buffer_usage_t usage) {
		glGenBuffers(1, &obj);
		glBindBuffer(GL_ARRAY_BUFFER, obj);
		glBufferData(GL_ARRAY_BUFFER, size, null, usage);
		glBindBuffer(GL_ARRAY_BUFFER, 0);
	}

	this(Vec2[] data, buffer_usage_t usage) { this(cast(float[])data, usage); }
	this(Vec3[] data, buffer_usage_t usage) { this(cast(float[])data, usage); }
	this(Vec4[] data, buffer_usage_t usage) { this(cast(float[])data, usage); }

	this(float[] data, buffer_usage_t usage) {
		glGenBuffers(1, &obj);
		this.data(data, usage);
	}

	this(ref Mesh mesh, buffer_usage_t usage, F f) {
		VertexDataBuffer data;

		foreach (v; mesh.vertices) {
			f(v, data);
		}

		glGenBuffers(1, &obj);
		this.data(data.values, usage);
	}

	~this() {
		glDeleteBuffers(1, &obj);
	}

	ref VertexBuffer opOpAssign(string s)(ref VertexBuffer other) {
		if (s == "=") {
			gc.copy(other.obj, obj, true);
		}
		return this;
	}

	public {
		@property uint id() {
			return obj;
		}
	
		void data(void[] data, buffer_usage_t usage) {
			glBindBuffer(GL_ARRAY_BUFFER, obj);
			glBufferData(GL_ARRAY_BUFFER, data.length, data.ptr, usage);
			glBindBuffer(GL_ARRAY_BUFFER, 0);
		}

		void subData(void[] data, size_t offset) {
			glBindBuffer(GL_ARRAY_BUFFER, obj);
			glBufferSubData(GL_ARRAY_BUFFER, offset, data.length, data.ptr);
			glBindBuffer(GL_ARRAY_BUFFER, 0);
		}

		void getSubData(void* data, size_t offset, size_t length) {
			glBindBuffer(GL_ARRAY_BUFFER, obj);
			glGetBufferSubData(GL_ARRAY_BUFFER, offset, length, data);
			glBindBuffer(GL_ARRAY_BUFFER, 0);
		}
	}
}