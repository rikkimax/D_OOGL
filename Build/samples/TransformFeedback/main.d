module samples.TransformsFeedback.main;

import gl.oogl;
import std.stdio : writeln;

int main() {
	Window window = new Window(800, 600, "OpenGL Window", WindowStyle.Close);
	Context gl = window.getContext();
	
	/* initShader */
	
	Shader vert = new Shader(ShaderType.Vertex, """
#version 330

layout(location = 0) in vec2 position;

out vec2 outPosition;

void main(){
   outPosition = position + vec2(0.1, 0.1);
}
""");
	
	Vec2 vertices[3];
	vertices[0] = Vec2(-0.9f, -0.9f);
	vertices[1] = Vec2(0.9f, -0.9f);
	vertices[2] = Vec2(0.0f, 0.9f);
	
	Program program = new Program();
	program.attach(vert);
	TransformFeedback tf = new TransformFeedback(vertices.sizeof, program, Primitive.Points, ["outPosition\0"]);
	program.link();
	
	Attribute positionLocation = program.getAttribute("position");
	
	VertexArray vao = new VertexArray();
	
	VertexBuffer inputBuffer = new VertexBuffer(vertices, BufferUsage.StaticDraw);
	vao.bindAttribute(0, inputBuffer, Type.Float, 2);
	VertexBuffer outputBuffer = tf.buffer;
	
	/* processPoints */
	
	bool once = true;
	
	Event ev;
	while(window.isOpen()) {
		while(window.getEvent(ev)){}
		
		if (once) {
			tf.begin();
			tf.beginQuery(TransformTarget.TransformFeedbackPrimitivesWritten);
			
			gl.drawArrays(vao, Primitive.Points, 0, 3);
			
			writeln("Points drawn: ", tf.endQuery());
			tf.end();
			
			float[6] result;
			outputBuffer.getSubData(&result, 0, result.sizeof);
			writeln(result);
			
			once = false;
		}
		window.present();
	}
	return 0;
}