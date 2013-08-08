module gl.util.mesh;
import gl.math.vec2;
import gl.math.vec3;

struct Vertex {
	Vec3 pos;
	Vec2 tex;
	Vec3 normal;
}

class Mesh {
	private {
		Vertex[] _vertices;
	}

	this(string filename);

	public {
		@property Vertex[] vertices() {
			return _vertices;
		}

		int vertexCount() {
			return cast(uint)_vertices.length;
		}
	}
}