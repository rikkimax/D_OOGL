module gl.math.util;
import gl.math.mat4;
import gl.math.vec3;
import gl.math.vec4;
import std.math : cos, sin, tan;
public import std.math : PI;

import std.stdio;
version(unittest) {
	import std.conv : text;
}

float rad(float degrees) {
	return degrees / 180.0f * PI;
}

unittest {
	float r = rad(180f);

	assert(text(r) == "3.14159");
}

float deg(float radians) {
	return radians / PI * 180.0f;
}

unittest {
	float d = deg(PI);

	assert(text(d) == "180");
}

Mat4 frustum(float left, float right, float bottom, float top, float near, float far) {
	Mat4 ret;
	
	ret[0] = near * 2.0f / (right - left);
	ret[5] = near * 2.0f / (top - bottom);
	ret[8] = (right + left) / (right - left);
	ret[9] = (top + bottom) / (top - bottom);
	ret[10] = (-far - near) / (far - near);
	ret[11] = -1;
	ret[14] = -2.0f * far * near / (far - near);
	ret[15] = 0;
	
	return ret;
}

unittest {
	Mat4 mat = frustum(100, 150, 50, 60, -10, 30);

	assert(text(mat.values) == "[-0.4, 0, 0, 0, 0, -2, 0, 0, 5, 11, -0.5, -1, 0, 0, 15, 0]");
}

Mat4 perspective(float fovy, float aspect, float near, float far) {
	float top = near * tan(fovy / 2.0f);
	float right = top * aspect;
	return frustum(-right, right, -top, top, near, far);
}

unittest {
	Mat4 mat = perspective(200, 3, -10, 20);

	assert(text(mat.values) == "[-0.567652, 0, 0, 0, 0, -1.70296, 0, 0, 0, 0, -0.333333, -1, 0, 0, 13.3333, 0]");
}

Mat4 ortho(float left, float right, float bottom, float top, float near, float far) {
	Mat4 ret;

	ret[0] = 2f / (right - left);
	ret[5] = 2f / (top - bottom);
	ret[10] = -2 / (far - near);
	ret[12] = -(left + right) / (right - left);
	ret[13] = -(top + bottom) / (top - bottom);
	ret[14] = -(far + near) / (far - near);
	
	return ret;
}

unittest {
	Mat4 mat = ortho(-100, 100, -100, 100, -10, 20);

	assert(text(mat.values) == "[0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, -0.0666667, 0, -0, -0, -0.333333, 0]");
}

Mat4 lookAt(ref Vec3 eye, ref Vec3 center, ref Vec3 up) {
	Mat4 ret;
	Vec3 t;

	t = Vec3(eye - center);
	Vec3 z = t.normal();

	t = Vec3(z.y * z.z - up.z * z.y,
	         up.z * z.x - up.x * z.z,
	         up.x * z.y - up.y * z.x);
	Vec3 x = t.normal();

	t = Vec3(z.y * x.z - z.z * x.y,
	         z.z * x.x - z.x * x.z,
	         z.x * x.y - z.y * x.x);
	Vec3 y = t.normal();

	ret = Mat4(x.x, y.x, z.x, x.y,
	           y.y, z.y, x.z, y.z,
	           z.z, -x.dot(eye), -y.dot(eye), -z.dot(eye),
	           0f, 0f, 0f, 0f);
	return ret;
}

unittest {
	Vec3 eye = Vec3(20, 20, 100);
	Vec3 center = Vec3(0, 0, 0);
	Vec3 up = Vec3(0, 1, 0);
	Mat4 lookAt = lookAt(eye, center, up);
	
	assert(text(lookAt.values) == "[0.693375, -0.167374, 0.19245, 0, 0.97265, 0.19245, -0.720577, -0.161055, 0.96225, 58.1902, -0, -103.923, 0, 0, 0, 0]");
}

// left bottom width height = viewport
Vec3 unProject(ref Vec3 vec, ref Mat4 view, ref Mat4 proj, float[4] viewport) {
	Mat4 t;

	t = proj * view;
	Mat4 inv = t.inverse();
	Vec3 v = Vec3((vec.x - viewport[0]) * 2.0f / viewport[2] - 1.0f,
	       (vec.y - viewport[1]) * 2.0f / viewport[3] - 1.0f,
	       2.0f * vec.z - 1.0f);

	Vec3 ret = inv * v;
	float w = inv[3] * v.x + inv[7] * v.y + inv[11] * v.z + inv[15];
	return ret / w;
}

unittest {
	Vec3 val;
	Mat4 view;
	Mat4 proj;
	Vec3 vec = unProject(val, view, proj, [-100f, -100f, 200f, 200f]);

	// TODO unittest
}

// left bottom width height = viewport
Vec3 project(ref Vec3 vec, ref Mat4 view, ref Mat4 proj, float[4] viewport) {
	Mat4 trans = proj * view;
	Vec3 v = trans * vec;

	float w = trans[3] * vec.x + trans[7] * vec.y + trans[11] * vec.z + trans[15];
	v /= w;

	return Vec3(viewport[0] + viewport[2] * (v.x + 1.0f) / 2.0f,
	            viewport[1] + viewport[3] * (v.y + 1.0f) / 2.0f,
	            (v.z + 1.0f) / 2.0f);
}
	  
unittest {
	Vec3 val;
	Mat4 view;
	Mat4 proj;
	Vec3 vec = project(val, view, proj, [-100f, -100f, 200f, 200f]);

	// TODO unittest
}