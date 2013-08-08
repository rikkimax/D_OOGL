module samples.Triangle.main;

import gl.oogl;

int main() {
	Window window = new Window(800, 600, "OpenGL Window", WindowStyle.Close);
	Context gl = window.getContext();

	Shader vert = new Shader(ShaderType.Vertex, "#version 150\nin vec2 position; void main() { gl_Position = vec4(position, 0.0, 1.0); }");
	Shader frag = new Shader(ShaderType.Fragment, "#version 150\nout vec4 outColor; void main() { outColor = vec4(1.0, 0.0, 0.0, 1.0); }");
	Program program = new Program(vert, frag);

	float[] vertices = [
		-0.5f, -0.5f, 0.0f,
        0.5f, -0.5f, 0.0f,
        0.0f, 0.5f, 0.0f
    ];

	VertexBuffer vbo = new VertexBuffer(vertices, BufferUsage.StaticDraw);
	VertexArray vao = new VertexArray();
	vao.bindAttribute(program.getAttribute("position"), vbo, Type.Float, 3);

	Event ev;
	while(window.isOpen()) {
		while(window.getEvent(ev)){}

		gl.clear();

		gl.drawArrays(vao, Primitive.Triangles, 0, 3);

		window.present();
	}

	return 0;
}