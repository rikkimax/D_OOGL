module gl.math.vec2;
import std.math : acos, sqrt;

version(unittest) {
	import std.conv : text;
}

struct Vec2 {
	private {
		float _x = 0f;
		float _y = 0f;
	}

	this(float x = 0f, float y = 0f) {
		_x = x;
		_y = y;
	}

	this (Vec2 v) {
		_x = v.x;
		_y = v.y;
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

	/*
	 * Assignment operators (this + other = this)
	 */

	Vec2 opOpAssign(string s)(ref Vec2 v) {
		switch (s) {
			case "+":
				_x += v.x;
				_y += v.y;
				break;
			case "-":
				_x -= v.x;
				_y -= v.y;
				break;
			case "*":
				_x *= v.x;
				_y *= v.y;
				break;
			case "/":
				_x /= v.x;
				_y /= v.y;
				break;
			default:
				break;
		}
		return this;
	}

	Vec2 opOpAssign(string s)(float n) {
		switch (s) {
			case "*":
				_x *= n;
				_y *= n;
				break;
			case "/":
				_x /= n;
				_y /= n;
				break;
			case "+":
				_x += n;
				_y += n;
				break;
			case "-":
				_x -= n;
				_y -= n;
				break;
			default:
				break;
		}
		return this;
	}


	/*
	 * Manipulation operators (this + other = new)
	 */

	Vec2 opBinary(string s)(ref Vec2 v) {
		Vec2 ret = Vec2(this);
		with (ret) {
			switch (s) {
				case "+":
					_x += v.x;
					_y += v.y;
					break;
				case "-":
					_x -= v.x;
					_y -= v.y;
					break;
				case "*":
					_x *= v.x;
					_y *= v.y;
					break;
				case "/":
					_x /= v.x;
					_y /= v.y;
					break;
				default:
					break;
			}
		}
		return ret;
	}
	
	Vec2 opBinary(string s)(float n) {
		Vec2 ret = Vec2(this);
		with (ret) {
			switch (s) {
				case "*":
					_x *= n;
					_y *= n;
					break;
				case "/":
					_x /= n;
					_y /= n;
					break;
				case "+":
					_x += n;
					_y += n;
					break;
				case "-":
					_x -= n;
					_y -= n;
					break;
				default:
					break;
			}
		}
		return ret;
	}

	bool opEquals(Vec2 v) {
		return _x == v.x && _y == v.y;
	}

	bool opEquals(float v) {
		return _x + _y == v;
	}
}

unittest {
	Vec2 vec;
	assert(vec == 0);

	vec += 1f;

	assert(vec == 1 * 2);
}

unittest {
	Vec2 v1 = Vec2(2f, 2f);
	Vec2 v2 = Vec2(v1);
	Vec2 ret = v1 * v2;

	assert(v1 == v2);
	assert(v1 == 2 * 2);
	assert(ret == 4 * 2);
}

float dot(ref Vec2 _v, ref Vec2 v) {
	with (_v) {
		return x * v.x + y * v.y;
	}
}

unittest {
	Vec2 v1 = Vec2(1f, 2f);
	Vec2 v2 = Vec2(2f, 1f);

	assert(v1.dot(v2) == 4);
}

float angle(ref Vec2 _v, ref Vec2 v) {
	return acos(_v.dot(v) / _v.length() / v.length());
}

unittest {
	Vec2 v1 = Vec2(1f, 2f);
	Vec2 v2 = Vec2(2f, 1f);
	
	assert(text(v1.angle(v2)) == "0.643501");
}

float lengthSqr(ref Vec2 _v) {
	with (_v) {
		return x * x + y * y;
	}
}

unittest {
	Vec2 vec = Vec2(1f, 2f);

	assert(vec.lengthSqr() == (1 * 1) + (2 * 2));
}

float length(ref Vec2 _v) {
	with(_v) {
		return sqrt(x * x + y * y);
	}
}

unittest {
	Vec2 vec = Vec2(1f, 2f);

	assert(text(vec.length()) == "2.23607");
}

float distance(ref Vec2 _v, ref Vec2 v) {
	Vec2 ret = _v - v;
	return ret.length();
}

unittest {
	Vec2 v1 = Vec2(1f, 2f);
	Vec2 v2 = Vec2(2f, 1f);

	assert(text(v1.distance(v2)) == "1.41421");
}

Vec2 normal(ref Vec2 _v) {
	return _v / _v.length();
}

unittest {
	Vec2 vec = Vec2(1f, 2f);

	assert(text(vec.normal()) == "Vec2(0.447214, 0.894427)");
}