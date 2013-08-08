module gl.math.vec3;
import std.math : acos, sqrt;

version(unittest) {
	import std.conv : text;
}

struct Vec3 {
	private {
		float _x = 0f;
		float _y = 0f;
		float _z = 0f;
	}

	this(float x = 0f, float y = 0f, float z = 0f) {
		_x = x;
		_y = y;
		_z = z;
	}

	this (Vec3 v) {
		_x = v.x;
		_y = v.y;
		_z = v.z;
	}

	@property float x() {
		return _x;
	}
	
	@property void x(float x) {
		_x = x;
	}

	@property float y() {
		return _y;
	}
	
	@property void y(float y) {
		_y = y;
	}

	@property float z() {
		return _z;
	}
	
	@property void z(float z) {
		_z = z;
	}

	/*
	 * Assignment operators (this + other = this)
	 */

	Vec3 opOpAssign(string s)(ref Vec3 v) {
		switch (s) {
			case "+":
				_x += v.x;
				_y += v.y;
				_z += v.z;
				break;
			case "-":
				_x -= v.x;
				_y -= v.y;
				_z -= v.z;
				break;
			case "*":
				_x *= v.x;
				_y *= v.y;
				_z *= v.z;
				break;
			case "/":
				_x /= v.x;
				_y /= v.y;
				_z /= v.z;
				break;
			default:
				break;
		}
		return this;
	}

	Vec3 opOpAssign(string s)(float n) {
		switch (s) {
			case "*":
				_x *= n;
				_y *= n;
				_z *= n;
				break;
			case "/":
				_x /= n;
				_y /= n;
				_z /= n;
				break;
			case "+":
				_x += n;
				_y += n;
				_z += n;
				break;
			case "-":
				_x -= n;
				_y -= n;
				_z -= n;
				break;
			default:
				break;
		}
		return this;
	}


	/*
	 * Manipulation operators (this + other = new)
	 */

	Vec3 opBinary(string s)(ref Vec3 v) {
		Vec3 ret = Vec3(this);
		with (ret) {
			switch (s) {
				case "+":
					_x += v.x;
					_y += v.y;
					_z += v.z;
					break;
				case "-":
					_x -= v.x;
					_y -= v.y;
					_z -= v.z;
					break;
				case "*":
					_x *= v.x;
					_y *= v.y;
					_z *= v.z;
					break;
				case "/":
					_x /= v.x;
					_y /= v.y;
					_z /= v.z;
					break;
				default:
					break;
			}
		}
		return ret;
	}
	
	Vec3 opBinary(string s)(float n) {
		Vec3 ret = Vec3(this);
		with (ret) {
			switch (s) {
				case "*":
					_x *= n;
					_y *= n;
					_z *= n;
					break;
				case "/":
					_x /= n;
					_y /= n;
					_z /= n;
					break;
				case "+":
					_x += n;
					_y += n;
					_z += n;
					break;
				case "-":
					_x -= n;
					_y -= n;
					_z -= n;
					break;
				default:
					break;
			}
		}
		return ret;
	}

	bool opEquals(Vec3 v) {
		return _x == v.x && _y == v.y && _z == v.z;
	}

	bool opEquals(float v) {
		return _x + _y + _z == v;
	}
}

unittest {
	Vec3 vec;
	assert(vec == 0);

	vec += 1f;

	assert(vec == 1 * 3);
}

unittest {
	Vec3 v1 = Vec3(2f, 2f, 2f);
	Vec3 v2 = Vec3(v1);
	Vec3 ret = v1 * v2;

	assert(v1 == v2);
	assert(v1 == 2 * 3);
	assert(ret == 4 * 3);
}

Vec3 cross(ref Vec3 _v, ref Vec3 v) {
	with (_v) {
		Vec3 ret = Vec3(y * v.z - z * v.y,
					z * v.x - x * v.z,
					x * v.y - y * v.x);
		return ret;
	}
}

unittest {
	Vec3 v1 = Vec3(1f, 2f, 3f);
	Vec3 v2 = Vec3(3f, 2f, 1f);
	assert(v1.cross(v2) == Vec3(-4, 8, -4));
}

float dot(ref Vec3 _v, ref Vec3 v) {
	with (_v) {
		return x * v.x + y * v.y + z * v.z;
	}
}

unittest {
	Vec3 v1 = Vec3(1f, 2f, 3f);
	Vec3 v2 = Vec3(3f, 2f, 1f);
	assert(v1.dot(v2) == 10);
}

float angle(ref Vec3 _v, ref Vec3 v) {
	return acos(_v.dot(v) / _v.length() / v.length());
}

unittest {
	Vec3 v1 = Vec3(1f, 2f, 1f);
	Vec3 v2 = Vec3(v1);
	
	assert(text(v1.angle(v2)) == "0.000488281");
}

float lengthSqr(ref Vec3 _v) {
	with (_v) {
		return x * x + y * y + z * z;
	}
}

unittest {
	Vec3 vec = Vec3(1f, 2f, 3f);

	assert(vec.lengthSqr() == (1 * 1) + (2 * 2) + (3 * 3));
}

float length(ref Vec3 _v) {
	with(_v) {
		return sqrt(x * x + y * y + z * z);
	}
}

unittest {
	Vec3 vec = Vec3(1f, 2f, 3f);
	assert(text(vec.length()) == "3.74166");
}

float distance(ref Vec3 _v, ref Vec3 v) {
	Vec3 ret = _v - v;
	return ret.length();
}

unittest {
	Vec3 v1 = Vec3(1f, 2f, 3f);
	Vec3 v2 = Vec3(3f, 2f, 1f);

	assert(text(v1.distance(v2)) == "2.82843");
}

Vec3 normal(ref Vec3 _v) {
	return _v / _v.length();
}

unittest {
	Vec3 vec = Vec3(1f, 2f, 3f);

	assert(text(vec.normal()) == "Vec3(0.267261, 0.534522, 0.801784)");
}