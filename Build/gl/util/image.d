module gl.util.image;
import gl.util.color;

struct Image {
	private {
		Color[] image;
		ushort _width;
		ushort _height;
	}

	this(ref Image other) {
		image = other.image;
		_width = other.width;
		_height = other.height;
	}

	this(ushort width, ushort height, ref Color background) {
		for (int i = 0; i < width * height; i++) {
			image ~= Color(background);
		}
		_width = width;
		_height = height;
	}

	this(ushort width, ushort height, ubyte[] pixels) {
		for (int i = 0; i < pixels.length; i += 4) {
			image ~= Color(pixels[i], pixels[i + 1], pixels[i + 2], pixels[i + 3]);
		}
		_width = width;
		_height = height;
	}

	ref Image opOpAssign(ref Image other) {
		image = other.image;
		_width = other.width;
		_height = other.height;

		return this;
	}

	
	Color opIndex(ushort x, ushort y) {
		uint index = x * y;
		if (index < image.length)
			return image[index];
		else
			return Color.init;
	}
	
	void opIndexAssign(Color color, ushort x, ushort y) {
		uint index = x * y;
		if (index < image.length)
			image[index] = color;
	}

	public {
		@property ushort width() {
			return _width;
		}

		@property ushort height() {
			return _height;
		}

		@property Color[] pixels() {
			return image;
		}
	}
}