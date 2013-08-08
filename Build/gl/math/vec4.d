module gl.math.vec4;
import std.math : acos, sqrt;

version(unittest) {
	import std.conv : text;
}

struct Vec4 {
	private {
		float _x = 0f;
		float _y = 0f;
		float _z = 0f;
		float _w = 0f;
	}
	
	this(float x = 0f, float y = 0f, float z = 0f, float w = 0f) {
		_x = x;
		_y = y;
		_z = z;
		_w = w;
	}
	
	this (Vec4 v) {
		_x = v.x;
		_y = v.y;
		_z = v.z;
		_w = v.w;
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
	
	@property float w() {
		return _w;
	}
	
	@property void w(float w) {
		_w = w;
	}
	
	/*
	 * Assignment operators (this + other = this)
	 */
	
	Vec4 opOpAssign(string s)(ref Vec4 v) {
		switch (s) {
			case "+":
				_x += v.x;
				_y += v.y;
				_z += v.z;
				_w += v.w;
				break;
			case "-":
				_x -= v.x;
				_y -= v.y;
				_z -= v.z;
				_w -= v.w;
				break;
			case "*":
				_x *= v.x;
				_y *= v.y;
				_z *= v.z;
				_w *= v.w;
				break;
			case "/":
				_x /= v.x;
				_y /= v.y;
				_z /= v.z;
				_w /= v.w;
				break;
			default:
				break;
		}
		return this;
	}
	
	Vec4 opOpAssign(string s)(float n) {
		switch (s) {
			case "*":
				_x *= n;
				_y *= n;
				_z *= n;
				_w *= n;
				break;
			case "/":
				_x /= n;
				_y /= n;
				_z /= n;
				_w /= n;
				break;
			case "+":
				_x += n;
				_y += n;
				_z += n;
				_w += n;
				break;
			case "-":
				_x -= n;
				_y -= n;
				_z -= n;
				_w -= n;
				break;
			default:
				break;
		}
		return this;
	}
	
	
	/*
	 * Manipulation operators (this + other = new)
	 */
	
	Vec4 opBinary(string s)(ref Vec4 v) {
		Vec4 ret = Vec4(this);
		with (ret) {
			switch (s) {
				case "+":
					_x += v.x;
					_y += v.y;
					_z += v.z;
					_w += v.w;
					break;
				case "-":
					_x -= v.x;
					_y -= v.y;
					_z -= v.z;
					_w -= v.w;
					break;
				case "*":
					_x *= v.x;
					_y *= v.y;
					_z *= v.z;
					_w *= v.w;
					break;
				case "/":
					_x /= v.x;
					_y /= v.y;
					_z /= v.z;
					_w /= v.w;
					break;
				default:
					break;
			}
		}
		return ret;
	}
	
	Vec4 opBinary(string s)(float n) {
		Vec4 ret = Vec4(this);
		with (ret) {
			switch (s) {
				case "*":
					_x *= n;
					_y *= n;
					_z *= n;
					_w *= n;
					break;
				case "/":
					_x /= n;
					_y /= n;
					_z /= n;
					_w /= n;
					break;
				case "+":
					_x += n;
					_y += n;
					_z += n;
					_w += n;
					break;
				case "-":
					_x -= n;
					_y -= n;
					_z -= n;
					_w -= n;
					break;
				default:
					break;
			}
		}
		return ret;
	}
	
	bool opEquals(Vec4 v) {
		return _x == v.x && _y == v.y && _z == v.z && _w == v.w;
	}
	
	bool opEquals(float v) {
		return _x + _y + _z + w == v;
	}
}

unittest {
	Vec4 vec;
	assert(vec == 0);
	
	vec += 1f;
	
	assert(vec == 1 * 4);
}

unittest {
	Vec4 v1 = Vec4(2f, 2f, 2f, 2f);
	Vec4 v2 = Vec4(v1);
	Vec4 ret = v1 * v2;
	
	assert(v1 == v2);
	assert(v1 == 2 * 4);
	assert(ret == 4 * 4);
}