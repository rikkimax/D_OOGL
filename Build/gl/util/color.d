module gl.util.color;

struct Color {
	ubyte r, g, b, a;

	this(ubyte r = 0x0, ubyte g = 0x0, ubyte b = 0x0, ubyte a = 0x0) {
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}

	this(Color c) {
		this.r = c.r;
		this.g = c.g;
		this.b = c.b;
		this.a = c.a;
	}
}