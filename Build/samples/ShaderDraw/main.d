module samples.ShaderDraw.main;

import gl.oogl;

import std.stdio;

void main() {
	Window window = new Window(800, 600, "OpenGL Window");
	Context gl = window.getContext();
	writeln(DerelictGL3.loadedVersion);

	Shader vert = new Shader(ShaderType.Vertex, "#version 150\nin vec2 position; void main() { gl_Position = vec4(position, 0.0, 1.0); }");
	Shader frag = new Shader(ShaderType.Fragment, """
#version 330

uniform int win_Height;
uniform int win_Width;

uniform int com_Height;
uniform int com_Width;
uniform int com_X;
uniform int com_Y;
uniform int com_Count;

uniform vec4 borderColor;
uniform vec4 backgroundColor;

out vec4 outColor;

void main(){
    outColor = gl_FragCoord;

    float x = gl_FragCoord.x;
    float y = gl_FragCoord.y;

    bool component = x > com_X && x < com_X + com_Width &&
        y > win_Height - com_Y && y < (win_Height - com_Y) + com_Height;

    if (component) {
        float rlx = x - com_X; // left x base coord
        float rrx = com_Width - rlx;
        float rty = ((win_Height - com_Y) + com_Height) - y; // top y base coord
        float rby = com_Height - rty; // bottom y base coord

        float borderWidth = ((com_Height + com_Width) * 2f) / 100f;
        float borderWidth2 = borderWidth * 2;

        //draws a border
        if (rlx < borderWidth && rty < borderWidth) { // outer top left
            float d = distance(vec2(rlx, rty), vec2(borderWidth, borderWidth));
            if (d <= borderWidth) {
               outColor = borderColor;
            }
        } else if (rlx < borderWidth2 && rty < borderWidth2) { // inner top left
            float d = distance(vec2(rlx, rty), vec2(borderWidth2, borderWidth2));
            if (d >= borderWidth) {
               outColor = borderColor;
            } else {
               outColor = backgroundColor;
            }
        } else if (rrx < borderWidth && rty < borderWidth) { // outer top right
            float d = distance(vec2(rrx, rty), vec2(borderWidth, borderWidth));
            if (d <= borderWidth) {
               outColor = borderColor;
            }
        } else if (rrx < borderWidth2 && rty < borderWidth2) { // inner top right
            float d = distance(vec2(rrx, rty), vec2(borderWidth2, borderWidth2));
            if (d >= borderWidth) {
               outColor = borderColor;
            } else {
               outColor = backgroundColor;
            }
        } else if (rlx < borderWidth && rby < borderWidth) { // outer bottom left
            float d = distance(vec2(rlx, rby), vec2(borderWidth, borderWidth));
            if (d <= borderWidth) {
               outColor = borderColor;
            }
        } else if (rlx < borderWidth2 && rby < borderWidth2) { // inner bottom left
            float d = distance(vec2(rlx, rby), vec2(borderWidth2, borderWidth2));
            if (d >= borderWidth) {
               outColor = borderColor;
            } else {
               outColor = backgroundColor;
            }
        } else if (rrx < borderWidth && rby < borderWidth) { // outer bottom right
            float d = distance(vec2(rrx, rby), vec2(borderWidth, borderWidth));
            if (d <= borderWidth) {
               outColor = borderColor;
            }
        } else if (rrx < borderWidth2 && rby < borderWidth2) { // inner bottom right
            float d = distance(vec2(rrx, rby), vec2(borderWidth2, borderWidth2));
            if (d >= borderWidth) {
               outColor = borderColor;
            } else {
               outColor = backgroundColor;
            }
        } else if (rlx > borderWidth / 1.3 && rty > borderWidth / 1.3 && rrx > borderWidth / 1.3 && rby > borderWidth / 1.3) {
            // now with the content area
            outColor = backgroundColor;
        } else {
            outColor = borderColor;
        }
    }
}
""");
	
	Vec2[] vertices = [Vec2(-0.9f, 0.9f), // top left
					Vec2(-0.9, -0.85), // bottom left
                	Vec2(0.85, 0.9), // top right
	                
	                Vec2(0.9, 0.85), // top right
	                Vec2(0.9, -0.9), // bottom right
	                Vec2(-0.85, -0.9) // bottom left
	                ];

	Program program = new Program(vert, frag);

	VertexBuffer vbo = new VertexBuffer(vertices, BufferUsage.StaticDraw);
	VertexArray vao = new VertexArray();
	vao.bindAttribute(program.getAttribute("position"), vbo, Type.Float, 2);

	program.setUniform(program.getUniform("win_Height"), window.getHeight());
	program.setUniform(program.getUniform("win_Width"), window.getWidth());

	struct Component {
		int width, height;
		int x, y;
		bool clicked, hovered;
	}
	Component c;

	c.width = 200;
	c.height = 30;
	c.x = 200;
	c.y = 200;

	program.setUniform(program.getUniform("com_Height"), c.height);
	program.setUniform(program.getUniform("com_Width"), c.width);
	program.setUniform(program.getUniform("com_X"), c.x);
	program.setUniform(program.getUniform("com_Y"), c.y);


	Vec4 black = Vec4(0, 0, 0, 0);
	program.setUniform(program.getUniform("borderColor"), black);
	Vec4 white = Vec4(1, 1, 1, 1);
	program.setUniform(program.getUniform("backgroundColor"), white);

	Event ev;
	while(window.isOpen()) {
		while(window.getEvent(ev)){}
		
		gl.clear();
		
		gl.drawArrays(vao, Primitive.Triangles, 0, 6);
		
		window.present();
	}
}