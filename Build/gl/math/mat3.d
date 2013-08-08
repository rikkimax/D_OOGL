module gl.math.mat3;
import gl.math.vec3;
import gl.math.vec2;
import std.math : cos, sin;

version(unittest) {
	import std.conv : text;
}

struct Mat3 {
	private {
		Vec3[3] _m;
	}

	this(Mat3 v) {
		_m = v.vecs;
	}

	this(Vec3 col1, Vec3 col2, Vec3 col3) {
		_m = [col1, col2, col3];
	}

	this(float[9] v ...) {
		int count;
		for (int i = 0; i < 9; i += 3) {
			_m[count] = Vec3(v[i], v[i + 1], v[i + 2]);
			count++;
		}
	}

	@property Vec3[3] vecs() {
		return _m;
	}
	
	@property void vecs(Vec3[3] vecs) {
		_m = vecs;
	}

	@property float[9] values() {
		return cast(float[9])_m;
	}

	@property void values(float[9] v) {
		int count;
		for (int i = 0; i < 9; i += 3) {
			_m[count] = Vec3(v[i], v[i + 1], v[i + 2]);
			count++;
		}
	}

	float opIndex(uint index) {
		switch(index) {
			case 0:
				return _m[0].x;
				break;
			case 1:
				return _m[0].y;
				break;
			case 2:
				return _m[0].z;
				break;

			case 3:
				return _m[1].x;
				break;
			case 4:
				return _m[1].y;
			case 5:
				return _m[1].z;
				break;

			case 6:
				return _m[2].x;
				break;
			case 7:
				return _m[2].y;
				break;
			case 8:
				return _m[2].z;

			default:
				assert(0);
				break;
		}
	}
	
	void opIndexAssign(float v, uint index) {
		switch(index) {
			case 0:
				_m[0].x = v;
				break;
			case 1:
				_m[0].y = v;
				break;
			case 2:
				_m[0].z = v;
				break;

			case 3:
				_m[1].x = v;
				break;
			case 4:
				_m[1].y = v;
				break;
			case 5:
				_m[1].z = v;
				break;

			case 6:
				_m[2].x = v;
				break;
			case 7:
				_m[2].y = v;
				break;
			case 8:
				_m[2].z = v;
				break;

			default:
				break;
		}
	}

	/*
	 * Assignment operators (this + other = this)
	 */
	Mat3 opOpAssign(string s)(ref Mat3 v) {
		switch (s) {
			case "+":
				this[0] = this[0] + this[0] + this[1] + this[3] + this[2] + this[6];
				this[1] = this[3] + this[0] + this[4] + this[3] + this[5] + this[6];
				this[2] = this[6] + this[0] + this[7] + this[3] + this[8] + this[6];
				this[3] = this[0] + this[1] + this[1] + this[4] + this[2] + this[7];
				this[4] = this[3] + this[1] + this[4] + this[4] + this[5] + this[7];
				this[5] = this[6] + this[1] + this[7] + this[4] + this[8] + this[7];
				this[6] = this[0] + this[2] + this[1] + this[5] + this[2] + this[8];
				this[7] = this[3] + this[2] + this[4] + this[5] + this[5] + this[8];
				this[8] = this[6] + this[2] + this[7] + this[5] + this[8] + this[8];
				break;
			case "-":
				this[0] = this[0] - this[0] + this[1] - this[3] + this[2] - this[6];
				this[1] = this[3] - this[0] + this[4] - this[3] + this[5] - this[6];
				this[2] = this[6] - this[0] + this[7] - this[3] + this[8] - this[6];
				this[3] = this[0] - this[1] + this[1] - this[4] + this[2] - this[7];
				this[4] = this[3] - this[1] + this[4] - this[4] + this[5] - this[7];
				this[5] = this[6] - this[1] + this[7] - this[4] + this[8] - this[7];
				this[6] = this[0] - this[2] + this[1] - this[5] + this[2] - this[8];
				this[7] = this[3] - this[2] + this[4] - this[5] + this[5] - this[8];
				this[8] = this[6] - this[2] + this[7] - this[5] + this[8] - this[8];
				break;
			case "*":
				this[0] = this[0] * this[0] + this[1] * this[3] + this[2] * this[6];
				this[1] = this[3] * this[0] + this[4] * this[3] + this[5] * this[6];
				this[2] = this[6] * this[0] + this[7] * this[3] + this[8] * this[6];
				this[3] = this[0] * this[1] + this[1] * this[4] + this[2] * this[7];
				this[4] = this[3] * this[1] + this[4] * this[4] + this[5] * this[7];
				this[5] = this[6] * this[1] + this[7] * this[4] + this[8] * this[7];
				this[6] = this[0] * this[2] + this[1] * this[5] + this[2] * this[8];
				this[7] = this[3] * this[2] + this[4] * this[5] + this[5] * this[8];
				this[8] = this[6] * this[2] + this[7] * this[5] + this[8] * this[8];
				break;
			case "/":
				this[0] = this[0] / this[0] + this[1] / this[3] + this[2] / this[6];
				this[1] = this[3] / this[0] + this[4] / this[3] + this[5] / this[6];
				this[2] = this[6] / this[0] + this[7] / this[3] + this[8] / this[6];
				this[3] = this[0] / this[1] + this[1] / this[4] + this[2] / this[7];
				this[4] = this[3] / this[1] + this[4] / this[4] + this[5] / this[7];
				this[5] = this[6] / this[1] + this[7] / this[4] + this[8] / this[7];
				this[6] = this[0] / this[2] + this[1] / this[5] + this[2] / this[8];
				this[7] = this[3] / this[2] + this[4] / this[5] + this[5] / this[8];
				this[8] = this[6] / this[2] + this[7] / this[5] + this[8] / this[8];
				break;
			default:
				break;
		}
		return this;
	}

	Mat3 opOpAssign(string s)(float v) {
		switch (s) {
			case "+":
				_m[0] += v;
				_m[1] += v;
				_m[2] += v;
				break;
			case "-":
				_m[0] -= v;
				_m[1] -= v;
				_m[2] -= v;
				break;
			case "*":
				_m[0] *= v;
				_m[1] *= v;
				_m[2] *= v;
				break;
			case "/":
				_m[0] /= v;
				_m[1] /= v;
				_m[2] /= v;
				break;
			default:
				break;
		}
		return this;
	}
	
	/*
	 * Manipulation operators (this + other = new)
	 */

	Mat3 opBinary(string s)(ref Mat3 v) {
		Mat3 ret = Mat3(this);
		with (ret) {
			switch (s) {
				case "+":
					this[0] = this[0] + this[0] + this[1] + this[3] + this[2] + this[6];
					this[1] = this[3] + this[0] + this[4] + this[3] + this[5] + this[6];
					this[2] = this[6] + this[0] + this[7] + this[3] + this[8] + this[6];
					this[3] = this[0] + this[1] + this[1] + this[4] + this[2] + this[7];
					this[4] = this[3] + this[1] + this[4] + this[4] + this[5] + this[7];
					this[5] = this[6] + this[1] + this[7] + this[4] + this[8] + this[7];
					this[6] = this[0] + this[2] + this[1] + this[5] + this[2] + this[8];
					this[7] = this[3] + this[2] + this[4] + this[5] + this[5] + this[8];
					this[8] = this[6] + this[2] + this[7] + this[5] + this[8] + this[8];
					break;
				case "-":
					this[0] = this[0] - this[0] + this[1] - this[3] + this[2] - this[6];
					this[1] = this[3] - this[0] + this[4] - this[3] + this[5] - this[6];
					this[2] = this[6] - this[0] + this[7] - this[3] + this[8] - this[6];
					this[3] = this[0] - this[1] + this[1] - this[4] + this[2] - this[7];
					this[4] = this[3] - this[1] + this[4] - this[4] + this[5] - this[7];
					this[5] = this[6] - this[1] + this[7] - this[4] + this[8] - this[7];
					this[6] = this[0] - this[2] + this[1] - this[5] + this[2] - this[8];
					this[7] = this[3] - this[2] + this[4] - this[5] + this[5] - this[8];
					this[8] = this[6] - this[2] + this[7] - this[5] + this[8] - this[8];
					break;
				case "*":
					this[0] = this[0] * this[0] + this[1] * this[3] + this[2] * this[6];
					this[1] = this[3] * this[0] + this[4] * this[3] + this[5] * this[6];
					this[2] = this[6] * this[0] + this[7] * this[3] + this[8] * this[6];
					this[3] = this[0] * this[1] + this[1] * this[4] + this[2] * this[7];
					this[4] = this[3] * this[1] + this[4] * this[4] + this[5] * this[7];
					this[5] = this[6] * this[1] + this[7] * this[4] + this[8] * this[7];
					this[6] = this[0] * this[2] + this[1] * this[5] + this[2] * this[8];
					this[7] = this[3] * this[2] + this[4] * this[5] + this[5] * this[8];
					this[8] = this[6] * this[2] + this[7] * this[5] + this[8] * this[8];
					break;
				case "/":
					this[0] = this[0] / this[0] + this[1] / this[3] + this[2] / this[6];
					this[1] = this[3] / this[0] + this[4] / this[3] + this[5] / this[6];
					this[2] = this[6] / this[0] + this[7] / this[3] + this[8] / this[6];
					this[3] = this[0] / this[1] + this[1] / this[4] + this[2] / this[7];
					this[4] = this[3] / this[1] + this[4] / this[4] + this[5] / this[7];
					this[5] = this[6] / this[1] + this[7] / this[4] + this[8] / this[7];
					this[6] = this[0] / this[2] + this[1] / this[5] + this[2] / this[8];
					this[7] = this[3] / this[2] + this[4] / this[5] + this[5] / this[8];
					this[8] = this[6] / this[2] + this[7] / this[5] + this[8] / this[8];
					break;
				default:
					break;
			}
		}
		return ret;
	}

	Vec2 opBinary(string s)(ref Vec2 v) {
		Vec2 ret;
		with (ret) {
			switch (s) {
				case "+":
					ret.x = this[0] + v.x + this[3] + v.y + this[6];
					ret.y = this[1] + v.x + this[4] + v.y + this[7];
					break;
				case "-":
					ret.x = this[0] - v.x + this[3] - v.y + this[6];
					ret.y = this[1] - v.x + this[4] - v.y + this[7];
					break;
				case "*":
					ret.x = this[0] * v.x + this[3] * v.y + this[6];
					ret.y = this[1] * v.x + this[4] * v.y + this[7];
					break;
				case "/":
					ret.x = this[0] / v.x + this[3] / v.y + this[6];
					ret.y = this[1] / v.x + this[4] / v.y + this[7];
					break;
				default:
					break;
			}
		}
		return ret;
	}

	
	Mat3 opBinary(string s)(float v) {
		Mat3 ret = Mat3(this);
		with (ret) {
			switch (s) {
				case "+":
					m[0] += v;
					m[1] += v;
					m[2] += v;
					break;
				case "-":
					m[0] -= v;
					m[1] -= v;
					m[2] -= v;
					break;
				case "*":
					m[0] *= v;
					m[1] *= v;
					m[2] *= v;
					break;
				case "/":
					m[0] /= v;
					m[1] /= v;
					m[2] /= v;
					break;
				default:
					break;
			}
		}
		return ret;
	}

	bool opEquals(Mat3 v) {
		return _m == v.vecs;
	}

	bool opEquals(Vec3[3] v) {
		return _m == v;
	}

	bool opEquals(float[9] v ...) {
		int count;
		for (int i = 0; i < 9; i += 3) {
			if (Vec3(v[i], v[i + 1], v[i + 2]) != _m[count])
				return false;
			count++;
		}
		return true;
	}

	@property float determinant() {
		return this[0] * (this[8] * this[4] - this[5] * this[7]) +
			this[1] * (-this[8] * this[3] + this[5] * this[6]) +
			this[2] * (this[7] * this[3] - this[4] * this[6]);
	}
}

unittest {
	Mat3 m1 = Mat3(Vec3(1f, 1f, 1f), Vec3(2f, 2f, 2f), Vec3(3f, 3f, 3f));
	Mat3 m2 = Mat3(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f);

	Mat3 m3;
	m3.vecs = m2.vecs;
	assert(m3.vecs == m2.vecs);

	float[9] fam = m3.values;
	m1.values = fam;
	assert(m1 == fam);
}

unittest {
	Mat3 mat;

	mat += 2;
	assert(mat == [2, 2, 2, 2, 2, 2, 2, 2, 2]);

	mat *= 2;
	assert(mat == [4, 4, 4, 4, 4, 4, 4, 4, 4]);
}

unittest {
	Mat3 mat = Mat3(9f, 8f, 7f, 6f, 5f, 6f, 7f, 8f, 9f);

	assert(mat.determinant == -32);
}

Mat3 translate(ref Mat3 _v, ref Vec3 v) {
	return Mat3(1, 0, v.x,
	             0, 1, v.y,
	             0, 0, 1) * _v;
}

unittest {
	Mat3 mat = Mat3(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f);
	Vec3 vec = Vec3(1f, 2f, 3f);

	assert(mat.translate(vec) == [1, 0, 1, 0, 1, 2, 0, 0, 1]);
}

Mat3 scale(ref Mat3 _v, ref Vec2 v) {
	return Mat3(v.x, 0, 0,
	            0, v.y, 0,
	            0, 0, 1) * _v;
}

unittest {
	Mat3 mat = Mat3(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f);
	Vec2 vec = Vec2(1f, 2f);

	assert(mat.scale(vec) == [1, 0, 0, 0, 2, 0, 0, 0, 1]);
}

Mat3 rotation(ref Mat3 _v, float ang) {
	return Mat3(cos(ang), -sin(ang), 0,
	            sin(ang), cos(ang), 0,
	            0, 0, 1) * _v;
}

unittest {
	Mat3 mat = Mat3(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f);

	assert(text(mat.rotation(180).values) == "[-0.59846, 0.801153, 0, -0.801153, -0.59846, 0, 0, 0, 1]");
}

Mat3 tranpose(ref Mat3 _v) {
	with(_v) {
		return Mat3(values[0], values[3], values[6],
	           		values[1], values[4], values[7],
		        	values[2], values[5], values[8]);
	}
}

unittest {
	Mat3 mat = Mat3(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f);

	assert(mat.tranpose() == [1, 4, 7, 2, 5, 8, 3, 6, 9]);
}

Mat3 inverse(ref Mat3 _v) {
	with(_v) {
		float det = determinant;
		Mat3 ret = Mat3((values[8] * values[4] - values[5] * values[7]) / det,
		                (-values[8] * values[1] + values[2] * values[7]) / det,
		                (values[5] * values[1] - values[2] * values[4]) / det,
		                (-values[8] * values[3] + values[5] * values[6]) / det,
		                (values[8] * values[0] - values[2] * values[6]) / det,
		                (-values[5] * values[0] + values[2] * values[3]) / det,
		                (values[7] * values[3] - values[4] * values[6]) / det,
		                (-values[7] * values[0] + values[1] * values[6]) / det,
		                (values[4] * values[0] - values[1] * values[3]) / det);
		return ret;
	}
}

unittest {
	Mat3 mat = Mat3(9f, 8f, 7f, 6f, 5f, 6f, 7f, 8f, 9f);

	assert(text(mat.inverse().values) == "[0.09375, 0.5, -0.40625, 0.375, -1, 0.375, -0.40625, 0.5, 0.09375]");
}