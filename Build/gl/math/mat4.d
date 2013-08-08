module gl.math.mat4;
import gl.math.vec3;
import gl.math.vec4;
import std.math : cos, sin;

version(unittest) {
	import std.conv : text;
}

struct Mat4 {
	private {
		Vec4[4] _m;
	}
	
	this(Mat4 v) {
		_m = v.vecs;
	}
	
	this(Vec4 col1, Vec4 col2, Vec4 col3, Vec4 col4) {
		_m = [col1, col2, col3, col4];
	}
	
	this(float[16] v ...) {
		int count;
		for (int i = 0; i < 16; i += 4) {
			_m[count] = Vec4(v[i], v[i + 1], v[i + 2], v[i + 3]);
			count++;
		}
	}
	
	@property Vec4[4] vecs() {
		return _m;
	}
	
	@property void vecs(Vec4[4] vecs) {
		_m = vecs;
	}
	
	@property float[16] values() {
		return cast(float[16])_m;
	}
	
	@property void values(float[16] v) {
		int count;
		for (int i = 0; i < 16; i += 4) {
			_m[count] = Vec4(v[i], v[i + 1], v[i + 2], v[i + 3]);
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
				return _m[0].w;
				break;

			case 4:
				return _m[1].x;
			case 5:
				return _m[1].y;
				break;
			case 6:
				return _m[1].z;
				break;
			case 7:
				return _m[1].w;
				break;

			case 8:
				return _m[2].x;
			case 9:
				return _m[2].y;
				break;
			case 10:
				return _m[2].z;
				break;
			case 11:
				return _m[2].w;
				break;

			case 12:
				return _m[3].x;
			case 13:
				return _m[3].y;
				break;
			case 14:
				return _m[3].z;
				break;
			case 15:
				return _m[3].w;
				break;
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
				_m[0].w = v;
				break;
				
			case 4:
				_m[1].x = v;
				break;
			case 5:
				_m[1].y = v;
				break;
			case 6:
				_m[1].z = v;
				break;
			case 7:
				_m[1].w = v;
				break;
				
			case 8:
				_m[2].x = v;
				break;
			case 9:
				_m[2].y = v;
				break;
			case 10:
				_m[2].z = v;
				break;
			case 11:
				_m[2].w = v;
				break;
				
			case 12:
				_m[3].x = v;
				break;
			case 13:
				_m[3].y = v;
				break;
			case 14:
				_m[3].z = v;
				break;
			case 15:
				_m[3].w = v;
				break;
			default:
				break;
		}
	}
	
	/*
	 * Assignment operators (this + other = this)
	 */
	Mat4 opOpAssign(string s)(ref Mat4 v) {
		switch (s) {
			case "+":
				this[0] = this[0] + v[0] + this[4] + v[1] + this[8] + v[2] + this[12] + v[3];
				this[1] = this[0] + v[4] + this[4] + v[5] + this[8] + v[6] + this[12] + v[7];
				this[2] = this[0] + v[8] + this[4] + v[9] + this[8] + v[10] + this[12] + v[11];
				this[3] = this[0] + v[12] + this[4] + v[13] + this[8] + v[14] + this[12] + v[15];
				this[4] = this[1] + v[0] + this[5] + v[1] + this[9] + v[2] + this[13] + v[3];
				this[5] = this[1] + v[4] + this[5] + v[5] + this[9] + v[6] + this[13] + v[7];
				this[6] = this[1] + v[8] + this[5] + v[9] + this[9] + v[10] + this[13] + v[11];
				this[7] = this[1] + v[12] + this[5] + v[13] + this[9] + v[14] + this[13] + v[15];
				this[8] = this[2] + v[0] + this[6] + v[1] + this[10] + v[2] + this[14] + v[3];
				this[9] = this[2] + v[4] + this[6] + v[5] + this[10] + v[6] + this[14] + v[7];
				this[10] = this[2] + v[8] + this[6] + v[9] + this[10] + v[10] + this[14]+v[11];
				this[11] = this[2] + v[12] + this[6] + v[13] + this[10] + v[14] + this[14] + v[15];
				this[12] = this[3] + v[0] + this[7] + v[1] + this[11] + v[2] + this[15] + v[3];
				this[13] = this[3] + v[4] + this[7] + v[5] + this[11] + v[6] + this[15] + v[7];
				this[14] = this[3] + v[8] + this[7] + v[9] + this[11] + v[10] + this[15] + v[11];
				this[15] = this[3] + v[12] + this[7] + v[13] + this[11] + v[14] + this[15] + v[15];
				break;
			case "-":
				this[0] = this[0] - v[0] + this[4] - v[1] + this[8] - v[2] + this[12] - v[3];
				this[1] = this[0] - v[4] + this[4] - v[5] + this[8] - v[6] + this[12] - v[7];
				this[2] = this[0] - v[8] + this[4] - v[9] + this[8] - v[10] + this[12] - v[11];
				this[3] = this[0] - v[12] + this[4] - v[13] + this[8] - v[14] + this[12] - v[15];
				this[4] = this[1] - v[0] + this[5] - v[1] + this[9] - v[2] + this[13] - v[3];
				this[5] = this[1] - v[4] + this[5] - v[5] + this[9] - v[6] + this[13] - v[7];
				this[6] = this[1] - v[8] + this[5] - v[9] + this[9] - v[10] + this[13] - v[11];
				this[7] = this[1] - v[12] + this[5] - v[13] + this[9] - v[14] + this[13] - v[15];
				this[8] = this[2] - v[0] + this[6] - v[1] + this[10] - v[2] + this[14] - v[3];
				this[9] = this[2] - v[4] + this[6] - v[5] + this[10] - v[6] + this[14] - v[7];
				this[10] = this[2] - v[8] + this[6] - v[9] + this[10] - v[10] + this[14]-v[11];
				this[11] = this[2] - v[12] + this[6] - v[13] + this[10] - v[14] + this[14] - v[15];
				this[12] = this[3] - v[0] + this[7] - v[1] + this[11] - v[2] + this[15] - v[3];
				this[13] = this[3] - v[4] + this[7] - v[5] + this[11] - v[6] + this[15] - v[7];
				this[14] = this[3] - v[8] + this[7] - v[9] + this[11] - v[10] + this[15] - v[11];
				this[15] = this[3] - v[12] + this[7] - v[13] + this[11] - v[14] + this[15] - v[15];
				break;
			case "*":
				this[0] = this[0] * v[0] + this[4] * v[1] + this[8] * v[2] + this[12] * v[3];
				this[1] = this[0] * v[4] + this[4] * v[5] + this[8] * v[6] + this[12] * v[7];
				this[2] = this[0] * v[8] + this[4] * v[9] + this[8] * v[10] + this[12] * v[11];
				this[3] = this[0] * v[12] + this[4] * v[13] + this[8] * v[14] + this[12] * v[15];
				this[4] = this[1] * v[0] + this[5] * v[1] + this[9] * v[2] + this[13] * v[3];
				this[5] = this[1] * v[4] + this[5] * v[5] + this[9] * v[6] + this[13] * v[7];
				this[6] = this[1] * v[8] + this[5] * v[9] + this[9] * v[10] + this[13] * v[11];
				this[7] = this[1] * v[12] + this[5] * v[13] + this[9] * v[14] + this[13] * v[15];
				this[8] = this[2] * v[0] + this[6] * v[1] + this[10] * v[2] + this[14] * v[3];
				this[9] = this[2] * v[4] + this[6] * v[5] + this[10] * v[6] + this[14] * v[7];
				this[10] = this[2] * v[8] + this[6] * v[9] + this[10] * v[10] + this[14]*v[11];
				this[11] = this[2] * v[12] + this[6] * v[13] + this[10] * v[14] + this[14] * v[15];
				this[12] = this[3] * v[0] + this[7] * v[1] + this[11] * v[2] + this[15] * v[3];
				this[13] = this[3] * v[4] + this[7] * v[5] + this[11] * v[6] + this[15] * v[7];
				this[14] = this[3] * v[8] + this[7] * v[9] + this[11] * v[10] + this[15] * v[11];
				this[15] = this[3] * v[12] + this[7] * v[13] + this[11] * v[14] + this[15] * v[15];
				break;
			case "/":
				this[0] = this[0] / v[0] + this[4] / v[1] + this[8] / v[2] + this[12] / v[3];
				this[1] = this[0] / v[4] + this[4] / v[5] + this[8] / v[6] + this[12] / v[7];
				this[2] = this[0] / v[8] + this[4] / v[9] + this[8] / v[10] + this[12] / v[11];
				this[3] = this[0] / v[12] + this[4] / v[13] + this[8] / v[14] + this[12] / v[15];
				this[4] = this[1] / v[0] + this[5] / v[1] + this[9] / v[2] + this[13] / v[3];
				this[5] = this[1] / v[4] + this[5] / v[5] + this[9] / v[6] + this[13] / v[7];
				this[6] = this[1] / v[8] + this[5] / v[9] + this[9] / v[10] + this[13] / v[11];
				this[7] = this[1] / v[12] + this[5] / v[13] + this[9] / v[14] + this[13] / v[15];
				this[8] = this[2] / v[0] + this[6] / v[1] + this[10] / v[2] + this[14] / v[3];
				this[9] = this[2] / v[4] + this[6] / v[5] + this[10] / v[6] + this[14] / v[7];
				this[10] = this[2] / v[8] + this[6] / v[9] + this[10] / v[10] + this[14]/v[11];
				this[11] = this[2] / v[12] + this[6] / v[13] + this[10] / v[14] + this[14] / v[15];
				this[12] = this[3] / v[0] + this[7] / v[1] + this[11] / v[2] + this[15] / v[3];
				this[13] = this[3] / v[4] + this[7] / v[5] + this[11] / v[6] + this[15] / v[7];
				this[14] = this[3] / v[8] + this[7] / v[9] + this[11] / v[10] + this[15] / v[11];
				this[15] = this[3] / v[12] + this[7] / v[13] + this[11] / v[14] + this[15] / v[15];
				break;
			default:
				break;
		}
		return this;
	}
	
	Mat4 opOpAssign(string s)(float v) {
		switch (s) {
			case "+":
				_m[0] += v;
				_m[1] += v;
				_m[2] += v;
				_m[3] += v;
				break;
			case "-":
				_m[0] -= v;
				_m[1] -= v;
				_m[2] -= v;
				_m[3] -= v;
				break;
			case "*":
				_m[0] *= v;
				_m[1] *= v;
				_m[2] *= v;
				_m[3] *= v;
				break;
			case "/":
				_m[0] /= v;
				_m[1] /= v;
				_m[2] /= v;
				_m[3] /= v;
				break;
			default:
				break;
		}
		return this;
	}
	
	/*
	 * Manipulation operators (this + other = new)
	 */
	
	Mat4 opBinary(string s)(ref Mat4 v) {
		Mat4 ret = Mat4(this);
		with (ret) {
			switch (s) {
				case "+":
					this[0] = this[0] + v[0] + this[4] + v[1] + this[8] + v[2] + this[12] + v[3];
					this[1] = this[0] + v[4] + this[4] + v[5] + this[8] + v[6] + this[12] + v[7];
					this[2] = this[0] + v[8] + this[4] + v[9] + this[8] + v[10] + this[12] + v[11];
					this[3] = this[0] + v[12] + this[4] + v[13] + this[8] + v[14] + this[12] + v[15];
					this[4] = this[1] + v[0] + this[5] + v[1] + this[9] + v[2] + this[13] + v[3];
					this[5] = this[1] + v[4] + this[5] + v[5] + this[9] + v[6] + this[13] + v[7];
					this[6] = this[1] + v[8] + this[5] + v[9] + this[9] + v[10] + this[13] + v[11];
					this[7] = this[1] + v[12] + this[5] + v[13] + this[9] + v[14] + this[13] + v[15];
					this[8] = this[2] + v[0] + this[6] + v[1] + this[10] + v[2] + this[14] + v[3];
					this[9] = this[2] + v[4] + this[6] + v[5] + this[10] + v[6] + this[14] + v[7];
					this[10] = this[2] + v[8] + this[6] + v[9] + this[10] + v[10] + this[14]+v[11];
					this[11] = this[2] + v[12] + this[6] + v[13] + this[10] + v[14] + this[14] + v[15];
					this[12] = this[3] + v[0] + this[7] + v[1] + this[11] + v[2] + this[15] + v[3];
					this[13] = this[3] + v[4] + this[7] + v[5] + this[11] + v[6] + this[15] + v[7];
					this[14] = this[3] + v[8] + this[7] + v[9] + this[11] + v[10] + this[15] + v[11];
					this[15] = this[3] + v[12] + this[7] + v[13] + this[11] + v[14] + this[15] + v[15];
					break;
				case "-":
					this[0] = this[0] - v[0] + this[4] - v[1] + this[8] - v[2] + this[12] - v[3];
					this[1] = this[0] - v[4] + this[4] - v[5] + this[8] - v[6] + this[12] - v[7];
					this[2] = this[0] - v[8] + this[4] - v[9] + this[8] - v[10] + this[12] - v[11];
					this[3] = this[0] - v[12] + this[4] - v[13] + this[8] - v[14] + this[12] - v[15];
					this[4] = this[1] - v[0] + this[5] - v[1] + this[9] - v[2] + this[13] - v[3];
					this[5] = this[1] - v[4] + this[5] - v[5] + this[9] - v[6] + this[13] - v[7];
					this[6] = this[1] - v[8] + this[5] - v[9] + this[9] - v[10] + this[13] - v[11];
					this[7] = this[1] - v[12] + this[5] - v[13] + this[9] - v[14] + this[13] - v[15];
					this[8] = this[2] - v[0] + this[6] - v[1] + this[10] - v[2] + this[14] - v[3];
					this[9] = this[2] - v[4] + this[6] - v[5] + this[10] - v[6] + this[14] - v[7];
					this[10] = this[2] - v[8] + this[6] - v[9] + this[10] - v[10] + this[14]-v[11];
					this[11] = this[2] - v[12] + this[6] - v[13] + this[10] - v[14] + this[14] - v[15];
					this[12] = this[3] - v[0] + this[7] - v[1] + this[11] - v[2] + this[15] - v[3];
					this[13] = this[3] - v[4] + this[7] - v[5] + this[11] - v[6] + this[15] - v[7];
					this[14] = this[3] - v[8] + this[7] - v[9] + this[11] - v[10] + this[15] - v[11];
					this[15] = this[3] - v[12] + this[7] - v[13] + this[11] - v[14] + this[15] - v[15];
					break;
				case "*":
					this[0] = this[0] * v[0] + this[4] * v[1] + this[8] * v[2] + this[12] * v[3];
					this[1] = this[0] * v[4] + this[4] * v[5] + this[8] * v[6] + this[12] * v[7];
					this[2] = this[0] * v[8] + this[4] * v[9] + this[8] * v[10] + this[12] * v[11];
					this[3] = this[0] * v[12] + this[4] * v[13] + this[8] * v[14] + this[12] * v[15];
					this[4] = this[1] * v[0] + this[5] * v[1] + this[9] * v[2] + this[13] * v[3];
					this[5] = this[1] * v[4] + this[5] * v[5] + this[9] * v[6] + this[13] * v[7];
					this[6] = this[1] * v[8] + this[5] * v[9] + this[9] * v[10] + this[13] * v[11];
					this[7] = this[1] * v[12] + this[5] * v[13] + this[9] * v[14] + this[13] * v[15];
					this[8] = this[2] * v[0] + this[6] * v[1] + this[10] * v[2] + this[14] * v[3];
					this[9] = this[2] * v[4] + this[6] * v[5] + this[10] * v[6] + this[14] * v[7];
					this[10] = this[2] * v[8] + this[6] * v[9] + this[10] * v[10] + this[14]*v[11];
					this[11] = this[2] * v[12] + this[6] * v[13] + this[10] * v[14] + this[14] * v[15];
					this[12] = this[3] * v[0] + this[7] * v[1] + this[11] * v[2] + this[15] * v[3];
					this[13] = this[3] * v[4] + this[7] * v[5] + this[11] * v[6] + this[15] * v[7];
					this[14] = this[3] * v[8] + this[7] * v[9] + this[11] * v[10] + this[15] * v[11];
					this[15] = this[3] * v[12] + this[7] * v[13] + this[11] * v[14] + this[15] * v[15];
					break;
				case "/":
					this[0] = this[0] / v[0] + this[4] / v[1] + this[8] / v[2] + this[12] / v[3];
					this[1] = this[0] / v[4] + this[4] / v[5] + this[8] / v[6] + this[12] / v[7];
					this[2] = this[0] / v[8] + this[4] / v[9] + this[8] / v[10] + this[12] / v[11];
					this[3] = this[0] / v[12] + this[4] / v[13] + this[8] / v[14] + this[12] / v[15];
					this[4] = this[1] / v[0] + this[5] / v[1] + this[9] / v[2] + this[13] / v[3];
					this[5] = this[1] / v[4] + this[5] / v[5] + this[9] / v[6] + this[13] / v[7];
					this[6] = this[1] / v[8] + this[5] / v[9] + this[9] / v[10] + this[13] / v[11];
					this[7] = this[1] / v[12] + this[5] / v[13] + this[9] / v[14] + this[13] / v[15];
					this[8] = this[2] / v[0] + this[6] / v[1] + this[10] / v[2] + this[14] / v[3];
					this[9] = this[2] / v[4] + this[6] / v[5] + this[10] / v[6] + this[14] / v[7];
					this[10] = this[2] / v[8] + this[6] / v[9] + this[10] / v[10] + this[14]/v[11];
					this[11] = this[2] / v[12] + this[6] / v[13] + this[10] / v[14] + this[14] / v[15];
					this[12] = this[3] / v[0] + this[7] / v[1] + this[11] / v[2] + this[15] / v[3];
					this[13] = this[3] / v[4] + this[7] / v[5] + this[11] / v[6] + this[15] / v[7];
					this[14] = this[3] / v[8] + this[7] / v[9] + this[11] / v[10] + this[15] / v[11];
					this[15] = this[3] / v[12] + this[7] / v[13] + this[11] / v[14] + this[15] / v[15];
					break;
				default:
					break;
			}
		}
		return ret;
	}
	
	Vec3 opBinary(string s)(ref Vec3 v) {
		Vec3 ret;
		with (ret) {
			switch (s) {
				case "+":
					ret.x = this[0] + v.x + this[4] + v.y + this[8] + v.z + this[12];
					ret.y = this[1] + v.x + this[5] + v.y + this[9] + v.z + this[13];
					ret.z = this[2] + v.x + this[6] + v.y + this[10] + v.z + this[14];
					break;
				case "-":
					ret.x = this[0] - v.x + this[4] - v.y + this[8] - v.z + this[12];
					ret.y = this[1] - v.x + this[5] - v.y + this[9] - v.z + this[13];
					ret.z = this[2] - v.x + this[6] - v.y + this[10] - v.z + this[14];
					break;
				case "*":
					ret.x = this[0] * v.x + this[4] * v.y + this[8] * v.z + this[12];
					ret.y = this[1] * v.x + this[5] * v.y + this[9] * v.z + this[13];
					ret.z = this[2] * v.x + this[6] * v.y + this[10] * v.z + this[14];
					break;
				case "/":
					ret.x = this[0] / v.x + this[4] / v.y + this[8] / v.z + this[12];
					ret.y = this[1] / v.x + this[5] / v.y + this[9] / v.z + this[13];
					ret.z = this[2] / v.x + this[6] / v.y + this[10] / v.z + this[14];
					break;
				default:
					break;
			}
		}
		return ret;
	}
	
	
	Mat4 opBinary(string s)(float v) {
		Mat4 ret = Mat4(this);
		with (ret) {
			switch (s) {
				case "+":
					m[0] += v;
					m[1] += v;
					m[2] += v;
					m[3] += v;
					break;
				case "-":
					m[0] -= v;
					m[1] -= v;
					m[2] -= v;
					m[3] -= v;
					break;
				case "*":
					m[0] *= v;
					m[1] *= v;
					m[2] *= v;
					m[3] *= v;
					break;
				case "/":
					m[0] /= v;
					m[1] /= v;
					m[2] /= v;
					m[3] /= v;
					break;
				default:
					break;
			}
		}
		return ret;
	}
	
	bool opEquals(Mat4 v) {
		return _m == v.vecs;
	}
	
	bool opEquals(Vec4[4] v) {
		return _m == v;
	}
	
	bool opEquals(float[16] v ...) {
		int count;
		for (int i = 0; i < 16; i += 4) {
			if (Vec4(v[i], v[i + 1], v[i + 2], v[i + 3]) != _m[count])
				return false;
			count++;
		}
		return true;
	}
	
	@property float determinant() {
			return this[12] * this[9] * this[6] * this[3] - this[8] * this[13] * this[6] * this[3] - this[12] * this[5] * this[10] * this[3] + this[4] * this[13] * this[10] * this[3] +
				this[8] * this[5] * this[14] * this[3] - this[4] * this[9] * this[14] * this[3] - this[12] * this[9] * this[2] * this[7] + this[8] * this[13] * this[2] * this[7] +
				this[12] * this[1] * this[10] * this[7] - this[0] * this[13] * this[10] * this[7] - this[8] * this[1] * this[14] * this[7] + this[0] * this[9] * this[14] * this[7] +
				this[12] * this[5] * this[2] * this[11] - this[4] * this[13] * this[2] * this[11] - this[12] * this[1] * this[6] * this[11] + this[0] * this[13] * this[6] * this[11] +
				this[4] * this[1] * this[14] * this[11] - this[0] * this[5] * this[14] * this[11] - this[8] * this[5] * this[2] * this[15] + this[4] * this[9] * this[2] * this[15] +
				this[8] * this[1] * this[6] * this[15] - this[0] * this[9] * this[6] * this[15] - this[4] * this[1] * this[10] * this[15] + this[0] * this[5] * this[10] * this[15];
	}

	@property void identity() {
		_m[0].x = 1;
		_m[0].y = 0;
		_m[0].z = 0;
		_m[0].w = 0;

		_m[1].x = 0;
		_m[1].y = 1;
		_m[1].z = 0;
		_m[1].w = 0;

		_m[2].x = 0;
		_m[2].y = 0;
		_m[2].z = 1;
		_m[2].w = 0;

		_m[3].x = 0;
		_m[3].y = 0;
		_m[3].z = 0;
		_m[3].w = 1;
	}
}

unittest {
	Mat4 m1 = Mat4(Vec4(1f, 1f, 1f, 1f), Vec4(2f, 2f, 2f, 2f), Vec4(3f, 3f, 3f, 3f), Vec4(4f, 4f, 4f, 4f));
	Mat4 m2 = Mat4(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f, 10f, 11f, 12f, 13f, 14f, 15f, 16f);
	
	Mat4 m3;
	m3.vecs = m2.vecs;
	assert(m3.vecs == m2.vecs);
	
	float[16] fam = m3.values;
	m1.values = fam;
	assert(text(m1.values) == text(fam));
}

unittest {
	Mat4 mat;
	
	mat += 2;
	assert(mat == [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]);
	
	mat *= 2;
	assert(mat == [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]);
}

unittest {
	Mat4 mat = Mat4(10f, 9f, 8f, 7f, 6f, 5f, 10f, 3f, 6f, 7f, 8f, 9f, 10f, 11f, 12f, 23f);

	assert(mat.determinant == -960);
}

Mat4 translate(ref Mat4 _v, ref Vec4 v) {
	return Mat4(1, 0, 0, v.x,
	            0, 1, 0, v.y,
	            0, 0, 1, v.z,
	            0, 0, 0, 1) * _v;
}

unittest {
	Mat4 mat = Mat4(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f, 10f, 11f, 12f, 13f, 14f, 15f, 16f);
	Vec4 vec = Vec4(1f, 2f, 3f, 4f);

	assert(mat.translate(vec) == [1, 0, 0, 1, 0, 1, 0, 2, 0, 0, 1, 3, 0, 0, 0, 1]);
}

Mat4 scale(ref Mat4 _v, ref Vec3 v) {
	return Mat4(v.x, 0, 0, 0,
	            0, v.y, 0, 0,
	            0, 0, v.z, 0,
	            0, 0, 0, 1) * _v;
}

unittest {
	Mat4 mat = Mat4(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f, 10f, 11f, 12f, 13f, 14f, 15f, 16f);
	Vec3 vec = Vec3(1f, 2f, 2f);

	assert(mat.scale(vec) == [1, 0, 0, 0,
	                          0, 2, 0, 0,
	                          0, 0, 2, 0,
	                          0, 0, 0, 1]);
}

Mat4 rotateX(ref Mat4 _v, float ang) {
	return Mat4(1, 0, 0, 0,
	            0, cos(ang), -sin(ang), 0,
	            0, sin(ang), cos(ang), 0,
	            0, 0, 0, 1) * _v;
}

Mat4 rotateY(ref Mat4 _v, float ang) {
	return Mat4(cos(ang), 0, sin(ang), 0,
	            0, 1, 0, 0,
	            -sin(ang), 0, cos(ang), 0,
	            0, 0, 0, 1) * _v;
}

Mat4 rotateZ(ref Mat4 _v, float ang) {
	return Mat4(cos(ang), -sin(ang), 0, 0,
	            sin(ang), cos(ang), 0, 0,
	            0, 0, 1, 0,
	            0, 0, 0, 1) * _v;
}

Mat4 rotate(ref Mat4 _v, ref Vec3 axis, float ang) {
	float s = sin(ang);
	float c = cos(ang);
	float t = 1 - c;
	Vec3 a = axis.normal();

	with (a) {
		return Mat4((x * x * t + c), (x * y * t - z * s), (x * z * t + y * s), 0,
		            (y * x * t + z * s), (y * y * t + c), (y * z * t - x * s), 0,
		            (z * x * t - y * s), (z * y * t * x * s), (z * z * t + c), 0,
		            0, 0, 0, 1) * _v;
	}
}

unittest {
	Mat4 mat = Mat4(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f, 10f, 11f, 12f, 13f, 14f, 15f, 16f);
	
	assert(text(mat.rotateX(20).values) == "[1, 0, 0, 0, 0, 0.408082, -0.912945, 0, 0, 0.912945, 0.408082, 0, 0, 0, 0, 1]");
	assert(text(mat.rotateY(20).values) == "[0.408082, 0, 0.912945, 0, 0, 1, 0, 0, -0.912945, 0, 0.408082, 0, 0, 0, 0, 1]");
	assert(text(mat.rotateZ(20).values) == "[0.408082, -0.912945, 0, 0, 0.912945, 0.408082, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]");
	Vec3 axis = Vec3(1, 1, 1);
	assert(text(mat.rotate(axis, 20f).values) == "[0.605388, -0.329783, 0.724395, 0, 0.724395, 0.605388, -0.329783, 0, -0.329783, 0.103998, 0.605388, 0, 0, 0, 0, 1]");
}


Mat4 tranpose(ref Mat4 _v) {
	with(_v) {
		return Mat4(values[0], values[4], values[8], values[12],
		            values[1], values[5], values[9], values[13],
		            values[2], values[6], values[10], values[14],
		            values[3], values[7], values[11], values[15]);
	}
}

unittest {
	Mat4 mat = Mat4(1f, 2f, 3f, 4f, 5f, 6f, 7f, 8f, 9f, 10f, 11f, 12f, 13f, 14f, 15f, 16f);

	assert(mat.tranpose().values == [1, 5, 9, 13,
	                                 2, 6, 10, 14,
	                                 3, 7, 11, 15,
	                                 4, 8, 12, 16]);
}

Mat4 inverse(ref Mat4 _v) {
	with(_v) {
		float det = determinant;
		Mat4 ret;

		with(_v) {
			float t0 = values[0] * values[5] - values[1] * values[4];
			float t1 = values[0] * values[6] - values[2] * values[4];
			float t2 = values[0] * values[7] - values[3] * values[4];
			float t3 = values[1] * values[6] - values[2] * values[5];
			float t4 = values[1] * values[7] - values[3] * values[5];
			float t5 = values[2] * values[7] - values[3] * values[6];
			float t6 = values[8] * values[13] - values[9] * values[12];
			float t7 = values[8] * values[14] - values[10] * values[12];
			float t8 = values[8] * values[15] - values[11] * values[12];
			float t9 = values[9] * values[14] - values[10] * values[13];
			float t10 = values[9] * values[15] - values[11] * values[13];
			float t11 = values[10] * values[15] - values[11] * values[14];

			ret = Mat4((values[5] * t11 - values[6] * t10 + values[7] * t9) / det,
					(-values[1] * t11 + values[2] * t10 - values[3] * t9) / det,
					(values[13] * t5 - values[14] * t4 + values[15] * t3) / det,
					(-values[9] * t5 + values[10] * t4 - values[11] * t3) / det,
					(-values[4] * t11 + values[6] * t8 - values[7] * t7) / det,
					(values[0] * t11 - values[2] * t8 + values[3] * t7) / det,
					(-values[12] * t5 + values[14] * t2 - values[15] * t1) / det,
					(values[8] * t5 - values[10] * t2 + values[11] * t1) / det,
					(values[4] * t10 - values[5] * t8 + values[7] * t6) / det,
					(-values[0] * t10 + values[1] * t8 - values[3] * t6) / det,
					(values[12] * t4 - values[13] * t2 + values[15] * t0) / det,
					(-values[8] * t4 + values[9] * t2 - values[11] * t0) / det,
					(-values[4] * t9 + values[5] * t7 - values[6] * t6) / det,
					(values[0] * t9 - values[1] * t7 + values[2] * t6) / det,
					(-values[12] * t3 + values[13] * t1 - values[14] * t0) / det,
					(values[8] * t3 - values[9] * t1 + values[10] * t0 ) / det);
		}
		return ret;
	}
}

unittest {
	Mat4 mat = Mat4(10f, 9f, 8f, 7f, 6f, 5f, 10f, 3f, 6f, 7f, 8f, 9f, 10f, 11f, 12f, 23f);

	assert(text(mat.inverse().values) == "[0.2625, 0.166667, -0.770833, 0.2, -0.05, -0.333333, 0.916667, -0.3, -0.125, 0.166667, 0.0416667, -0, -0.025, -0, -0.125, 0.1]");
}