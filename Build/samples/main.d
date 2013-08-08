module samples.main;
import gl.oogl;

import std.stdio;

import core.thread;

void main() {
	Window window = new Window(800, 600, "OpenGL Window");
	Context gl = window.getContext();
	writeln(DerelictGL3.loadedVersion);

	/*gl.clearColor(Color(0, 0, 0 , 0));
	
	Vec3 vertices[3];
	vertices[0] = Vec3(-0.9f, -0.9f, 0.0f);
	vertices[1] = Vec3(0.9f, -0.9f, 0.0f);
	vertices[2] = Vec3(0.0f, 0.9f, 0.0f);
	
	VertexBuffer vbo = new VertexBuffer(cast(float[])vertices, BufferUsage.StaticDraw);

	VertexArray vao = new VertexArray();
	vao.bindAttribute(0, vbo, Type.Float, 3);

	gl.clear();

	gl.drawArrays(vao, Primitive.Triangles, 0, 3);*/


	Shader vert = new Shader(ShaderType.Vertex, "#version 150\nin vec2 position; void main() { gl_Position = vec4(position, 0.0, 1.0); }");
	Shader frag = new Shader(ShaderType.Fragment, "#version 150\nout vec4 outColor; void main() { outColor = vec4(1.0, 0.0, 0.0, 1.0); }");
	Program program = new Program(vert, frag);

	Vec3 vertices[3];
	vertices[0] = Vec3(-0.9f, -0.9f, 0.0f);
	vertices[1] = Vec3(0.9f, -0.9f, 0.0f);
	vertices[2] = Vec3(0.0f, 0.9f, 0.0f);

	VertexBuffer vbo = new VertexBuffer(vertices, BufferUsage.StaticDraw);
	VertexArray vao = new VertexArray();
	vao.bindAttribute(program.getAttribute("position"), vbo, Type.Float, 3);

	gl.clearColor(Color(0, 0, 0 , 0));

	Event ev;
L1: while (window.isOpen()) {
		while(window.getEvent(ev) && window.isOpen()) {
			if (ev.type == event_t.Close)
				break L1;
		}

		gl.clear();

		gl.drawArrays(vao, Primitive.Triangles, 0, 3);

		window.present();
	}



	/*window.setTitle("hi");

	Context context = window.getContext();
	writeln(DerelictGL3.loadedVersion);

	context.clearColor(Color(0, 0, 0 , 255));
	context.clear();*/

	//window.present();
	Thread.sleep(dur!"seconds"(2));
}