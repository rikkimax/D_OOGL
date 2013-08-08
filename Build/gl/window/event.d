module gl.window.event;

enum mouse_button_t {
	Left,
	Right,
	Middle
}

alias mouse_button_t MouseButton;

struct MouseEvent {
	uint x, y;
	union {
		int delta;
		mouse_button_t button;
	}
}

enum key_t {
	Unknown,
	F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12,
	A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
	Num0, Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9,
	LeftBracket, RightBracket, Semicolon, Comma, Period, Quote, Slash, Backslash, Tilde, Equals, Hyphen,
	Escape, Control, Shift, Alt, Space, Enter, Backspace, Tab, PageUp, PageDown, End, Home, Insert, Delete, Pause,
	Left, Right, Up, Down,
	Numpad0, Numpad1, Numpad2, Numpad3, Numpad4, Numpad5, Numpad6, Numpad7, Numpad8, Numpad9,
	Add, Subtract, Multiply, Divide
}

alias key_t Key;

struct KeyEvent {
	key_t code;
	bool alt;
	bool control;
	bool shift;
}

struct WindowEvent {
	union {
		int x;
		uint width;
	}
	union {
		int y;
		uint height;
	}
}

enum event_t {
	Unknown,
	Close,
	Resize,
	Move,
	Focus,
	Blur,
	KeyDown,
	KeyUp,
	MouseDown,
	MouseUp,
	MouseWheel,
	MouseMove
}

struct Event {
	event_t type;

	union {
		MouseEvent mouse;
		KeyEvent key;
		WindowEvent window;
	}
}