module gl.window.window;
import gl.window.event;
import gl.gl.context;

version(Posix) {
	public import gl.window.window_x11;
	import deimos.X11.X;
	import xtypes = derelict.util.xtypes;
	import deimos.X11.Xlib;
	alias WindowX11 Window;
}

enum window_style_t {
	Base = 0,
	Resize = 1,
	Close = 2,
	Fullscreen = 4
}

alias window_style_t WindowStyle;

abstract class WindowDef {
	protected {
		uint width, height;
		int x, y;
		bool open, focus;
		Event[] events;

		uint mousex, mousey;
		bool[3] mouse;
		bool[100] keys;

		gl.gl.context.Context context;

		version(Windows) {
			HWND window;
			DWORD style;
		} else version(Posix) {
			xtypes.Window window;
			XDisplay* display;
			Atom _close;
			bool fullscreen;
			int screen;
			int oldVideoMode;
		}
	}

	//this(ref Window window);
	this(uint width = 800, uint height = 600, string title = "Window", window_style_t style = window_style_t.Close) {}
	~this() {}

	public {
		int getX() {
			return x;
		}

		int getY() {
			return y;
		}

		uint getWidth() {
			return width;
		}

		uint getHeight() {
			return height;
		}

		bool isOpen() {
			return open;
		}

		bool hasFocus() {
			return focus;
		}

		void setPos(int x, int y);
		void setSize(uint width, uint height);

		void setTitle(string title);

		void setVisible(bool visible);

		void close();

		bool getEvent(ref Event ev);

		int getMouseX() {
			return mousex;
		}

		int getMouseY() {
			return mousey;
		}

		bool isMouseButtonDown(mouse_button_t button) 
		in {
			assert(mouse.length > button);
			assert(button >= 0);
		} body {
			return mouse[button];
		}

		bool isKeyDown(key_t key)
		in {
			assert(keys.length > key);
			assert(key >= 0);
		} body {
			return keys[key];
		}

		ref gl.gl.context.Context getContext(ubyte color = 32, ubyte depth = 24, ubyte stencil = 8, ubyte antialias = 1);
		void present();

		void forceUpdate();
	}

	protected {
		version(Windows) {
			LRESULT windowEvent(uint msg, WPARAM wParam, LPARAM lParam);
			extern(C) static LRESULT windowEventHandler(HWND hWnd, uint msg, WPARAM wParam, LPARAM lParam);
		} else version(Posix) {
			void enableFullscreen(bool enabled, int width = 0, int height = 0);
			void windowEvent(ref XEvent event);

			//extern(C) static bool checkEvent(_XDisplay*, XEvent* event, XPointer userData);
		}

		key_t translateKey(uint code);
	}
}