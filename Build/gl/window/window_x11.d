module gl.window.window_x11;
import gl.window.window;
import gl.window.event;
import gl.gl.context;

version(Posix) {
	import deimos.X11.X;
	import deimos.X11.Xlib;
	import deimos.X11.keysym;
	import deimos.X11.keysymdef;
	import deimos.X11.Xutil;
	import deimos.X11.extensions.Xrandr;
	import deimos.X11.extensions.randr;
	import derelict.util.xtypes : Display, XPointer, XID;
	import derelict.opengl3.glx;
	import derelict.opengl3.gl3 : DerelictGL3;

	class WindowX11 : WindowDef {
		//this(ref Window window);
		this(uint width = 800, uint height = 600, string title = "Window", window_style_t style = window_style_t.Close) {
			// Connect to X server
			display = XOpenDisplay(null);
			screen = DefaultScreen(display);
			
			// Configure window style
			fullscreen = cast(bool)(style & WindowStyle.Fullscreen);
			
			XSetWindowAttributes attributes;
			attributes.event_mask = FocusChangeMask | ButtonPressMask | ButtonReleaseMask | ButtonMotionMask | PointerMotionMask | KeyPressMask | KeyReleaseMask | StructureNotifyMask | EnterWindowMask | LeaveWindowMask;
			attributes.override_redirect = cast(Bool)fullscreen;
			
			int x, y;
			if (fullscreen) {
				x = 0;
				y = 0;
				
				enableFullscreen(true, width, height);
			} else {
				x = (DisplayWidth(display, screen) - width) / 2;
				y = (DisplayHeight(display, screen) - height) / 2;
			}
			
			// Create window on server
			deimos.X11.X.Window desktop = RootWindow(display, screen);
			int depth = DefaultDepth(display, screen);
			
			window = cast(uint)XCreateWindow(display, desktop, x, y, width, height, 0, depth, InputOutput, DefaultVisual(display, screen), CWEventMask | CWOverrideRedirect, &attributes);
			XStoreName(display, window, cast(char*)(title ~ '\0').ptr);
			
			// Window style
			if (!fullscreen)
			{
				Atom windowHints = XInternAtom(display, cast(char*)("_MOTIF_WM_HINTS\0".ptr), cast(Bool)false);
				
				// These are extensions, so they'll have to be manually defined
				struct WMHints
				{
					ulong Flags;
					ulong Functions;
					ulong Decorations;
					long InputMode;
					ulong State;
				};
				
				static const ulong MWM_HINTS_FUNCTIONS = 1 << 0;
				static const ulong MWM_HINTS_DECORATIONS = 1 << 1;
				static const ulong MWM_DECOR_BORDER = 1 << 1;
				static const ulong MWM_DECOR_RESIZEH = 1 << 2;
				static const ulong MWM_DECOR_TITLE = 1 << 3;
				static const ulong MWM_DECOR_MENU = 1 << 4;
				static const ulong MWM_DECOR_MINIMIZE = 1 << 5;
				static const ulong MWM_DECOR_MAXIMIZE = 1 << 6;
				static const ulong MWM_FUNC_RESIZE = 1 << 1;
				static const ulong MWM_FUNC_MOVE = 1 << 2;
				static const ulong MWM_FUNC_MINIMIZE = 1 << 3;
				static const ulong MWM_FUNC_MAXIMIZE = 1 << 4;
				static const ulong MWM_FUNC_CLOSE = 1 << 5;
				
				WMHints hints;
				hints.Flags = MWM_HINTS_FUNCTIONS | MWM_HINTS_DECORATIONS;
				hints.Decorations = MWM_DECOR_BORDER | MWM_DECOR_TITLE | MWM_DECOR_MINIMIZE | MWM_DECOR_MENU;
				hints.Functions = MWM_FUNC_MOVE | MWM_FUNC_MINIMIZE;
				
				if ((style & WindowStyle.Close) || ( style & WindowStyle.Resize)) {
					hints.Functions |= MWM_FUNC_CLOSE;
				}
				if (style & WindowStyle.Resize) {
					hints.Decorations |= MWM_DECOR_MAXIMIZE | MWM_DECOR_RESIZEH;
					hints.Functions |= MWM_FUNC_MAXIMIZE | MWM_FUNC_RESIZE;
				}
				
				const ubyte* ptr = cast(const ubyte*)(&hints);
				XChangeProperty(display, cast(ulong)window, windowHints, windowHints, 32, cast(int)PropModeReplace, cast(ubyte*)ptr, 5);
			}
			
			// Add input handler for close button
			_close = XInternAtom(display, cast(char*)("WM_DELETE_WINDOW\0".ptr), cast(Bool)false);
			XSetWMProtocols(display, window, &_close, 1);
			
			// Show window
			XMapWindow(display, window);
			XFlush(display);
			
			// Handle fullscreen input
			if (fullscreen) {
				XGrabPointer(display, cast(ulong)window, cast(Bool)true, cast(uint)0, cast(int)GrabModeAsync, cast(int)GrabModeAsync, window, None, CurrentTime);
				XGrabKeyboard(display, cast(ulong)window, cast(Bool)true, cast(int)GrabModeAsync, cast(int)GrabModeAsync, CurrentTime);
			}
			
			// Initialize window properties
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.open = true;
			this.mousex = 0;
			this.mousey = 0;

			this.mouse = 0;
			this.keys = 0;
			this.context = null;
		}

		~this() {
			if (!open) return;
			close();
		}

		public {
			override void setPos(int x, int y) {
				if(!open) return;
				XMoveWindow(display, cast(XID)window, x, y);
				XFlush(this.display);
			}

			override void setSize(uint width, uint height) {
				if(!open) return;
				XResizeWindow(display, cast(ulong)window, width, height);
				XFlush(display);
			}
			
			override void setTitle(string title) {
				if(!open) return;
				title ~= 0;
				XStoreName(display, cast(ulong)window, cast(char*)title.ptr);
			}
			
			override void setVisible(bool visible) {
				if(!open) return;
				if(visible)
					XMapWindow(display, cast(ulong)window);
				else
					XUnmapWindow(display, cast(ulong)window);
			}
			
			override void close() {
				XDestroyWindow(display, cast(ulong)window);
				XFlush(display);

				if(fullscreen) enableFullscreen(false);

				XCloseDisplay(display);

				open = false;
			}
			
			override bool getEvent(ref Event ev) {
				XEvent event;
				while(XCheckIfEvent(display, &event, &checkEvent, cast(char*)window)) {
					windowEvent(event);
				}
				//XNextEvent(display, &event);
				//windowEvent(event);

				if (events.length == 0) return false;
				ev = events[0];
				events = events[1..$];
				return true;
			}

			override ref gl.gl.context.Context getContext(ubyte color = 32, ubyte depth = 24, ubyte stencil = 8, ubyte antialias = 1) {
				if (context is null) {
					context = new gl.gl.context.Context(color, depth, stencil, antialias, display, screen, window);
					DerelictGL3.reload();
				}
				return context;
			}

			override void present() {
				assert(context !is null);
				context.activate();
				glXSwapBuffers(display, window);
			}

			override void forceUpdate() {
				XFlush(display);
			}
		}

		protected {
			override void enableFullscreen(bool enabled, int width = 0, int height = 0) {
				if (enabled) {
					XRRScreenConfiguration* config = XRRGetScreenInfo(display, RootWindow(display, screen));
					
					Rotation currentRotation;
					oldVideoMode = XRRConfigCurrentConfiguration(config, &currentRotation);
					
					int nbSizes;
					XRRScreenSize* sizes = XRRConfigSizes(config, &nbSizes);
					for (int i = 0; i < nbSizes; i++) {
						if (sizes[i].width == width && sizes[i].height == height) {
							XRRSetScreenConfig(display, config, RootWindow(display, screen), i, currentRotation, CurrentTime);
							break;
						}
					}
					
					XRRFreeScreenConfigInfo(config);
				} else {
					XRRScreenConfiguration* config = XRRGetScreenInfo(display, RootWindow(display, screen));
					Rotation currentRotation;
					XRRConfigCurrentConfiguration(config, &currentRotation);
					XRRSetScreenConfig(display, config, RootWindow(display, screen), oldVideoMode, currentRotation, CurrentTime);
					XRRFreeScreenConfigInfo(config);
				}
			}

			override void windowEvent(ref XEvent event) {
				static XComposeStatus keyboard;

				Event ev;
				ev.type = event_t.Unknown;
				
				// Translate XEvent to Event
				uint button = 0;
				char[32] buffer;
				KeySym symbol;
				switch (event.type) {
					case ClientMessage:
						if ((event.xclient.format == 32) && event.xclient.data.l[0] == cast(long)_close) {
							if (fullscreen) enableFullscreen(false);
							open = false;
							ev.type = event_t.Close;
						}
						break;
						
					case ConfigureNotify:
						if (cast(uint)event.xconfigure.width != width || cast(uint)event.xconfigure.height != height)
						{
							width = event.xconfigure.width;
							height = event.xconfigure.height;
							
							if (events.length == 0) {
								ev.type = event_t.Resize;
								ev.window.width = width;
								ev.window.height = height;
							} else if (events[$ - 1].type == event_t.Resize) {
								events[$ - 1].window.width = width;
								events[$ - 1].window.height = height;
							}
						} else if (event.xconfigure.x != x || event.xconfigure.y != y) {
							x = event.xconfigure.x;
							y = event.xconfigure.y;
							
							if (events.length == 0) {
								ev.type = event_t.Move;
								ev.window.x = x;
								ev.window.y = y;
							} else if (events[$ - 1].type == event_t.Move) {
								events[$ - 1].window.x = x;
								events[$ - 1].window.y = y;
							}
						}
						break;
						
					case FocusIn:
						ev.type = event_t.Focus;
						focus = true;
						break;
						
					case FocusOut:
						ev.type = event_t.Blur;
						focus = false;
						break;
						
					case KeyPress:
						XLookupString(cast(XKeyEvent*)(&event.xkey), buffer.ptr, cast(int)buffer.sizeof, &symbol, &keyboard);
						
						ev.type = event_t.KeyDown;
						ev.key.code = translateKey(cast(uint)symbol);
						ev.key.alt = cast(bool)(event.xkey.state & Mod1Mask);
						ev.key.control = cast(bool)(event.xkey.state & ControlMask);
						ev.key.shift = event.xkey.state & ShiftMask;
						
						keys[ev.key.code] = true;
						break;
						
					case KeyRelease:
						XLookupString(cast(XKeyEvent*)(&event.xkey), buffer.ptr, buffer.sizeof, &symbol, &keyboard);
						
						ev.type = event_t.KeyUp;
						ev.key.code = translateKey(cast(uint)symbol);
						ev.key.alt = cast(bool)(event.xkey.state & Mod1Mask);
						ev.key.control = cast(bool)(event.xkey.state & ControlMask);
						ev.key.shift = event.xkey.state & ShiftMask;
						
						keys[ev.key.code] = false;
						break;
						
					case ButtonPress:
						button = event.xbutton.button;
						
						if (button == Button1 || button == Button2 || button == Button3) {
							mousex = event.xbutton.x;
							mousey = event.xbutton.y;
							
							ev.type = event_t.MouseDown;
							ev.mouse.x = mousex;
							ev.mouse.y = mousey;
							
							if (button == Button1) ev.mouse.button = MouseButton.Left;
							else if (button == Button2) ev.mouse.button = MouseButton.Middle;
							else if (button == Button3) ev.mouse.button = MouseButton.Right;
						}
						break;
						
					case ButtonRelease:
						button = event.xbutton.button;
						
						if (button == Button1 || button == Button2 || button == Button3) {
							mousex = event.xbutton.x;
							mousey = event.xbutton.y;
							
							ev.type = event_t.MouseUp;
							ev.mouse.x = mousex;
							ev.mouse.y = mousey;
							
							if (button == Button1) ev.mouse.button = MouseButton.Left;
							else if (button == Button2) ev.mouse.button = MouseButton.Middle;
							else if (button == Button3) ev.mouse.button = MouseButton.Right;
						} else if (button == Button4 || button == Button5) {
							mousex = event.xbutton.x;
							mousey = event.xbutton.y;
							
							ev.type = event_t.MouseWheel;
							ev.mouse.delta = button == Button4 ? 1 : -1;
							ev.mouse.x = mousex;
							ev.mouse.y = mousey;
						}
						break;
						
					case MotionNotify:
						mousex = event.xmotion.x;
						mousey = event.xmotion.y;
						
						ev.type = event_t.MouseMove;
						ev.mouse.x = mousex;
						ev.mouse.y = mousey;
						break;
					default:
						break;
				}
				
				// Add event to internal queue
				if (ev.type != event_t.Unknown)
					events ~= ev;
			}

			extern(C) static Bool checkEvent(_XDisplay* display, XEvent* event, char* userData) {
				bool ret = event.xany.window == cast(xtypes.Window)userData;
				return cast(Bool)ret;
			}

			override key_t translateKey(uint code) {
				if (code >= 'a' && code <= 'z') code -= 'a' - 'A';
				switch ( code ) {
					case XK_Shift_L: return Key.Shift;
					case XK_Shift_R: return Key.Shift;
					case XK_Alt_L: return Key.Alt;
					case XK_Alt_R: return Key.Alt;
					case XK_Control_L: return Key.Control;
					case XK_Control_R: return Key.Control;
					case XK_semicolon: return Key.Semicolon;
					case XK_slash: return Key.Slash;
					case XK_equal: return Key.Equals;
					case XK_minus: return Key.Hyphen;
					case XK_bracketleft: return Key.LeftBracket;
					case XK_bracketright: return Key.RightBracket;
					case XK_comma: return Key.Comma;
					case XK_period: return Key.Period;
					case XK_dead_acute: return Key.Quote;
					case XK_backslash: return Key.Backslash;
					case XK_dead_grave: return Key.Tilde;
					case XK_Escape: return Key.Escape;
					case XK_space: return Key.Space;
					case XK_Return: return Key.Enter;
					case XK_KP_Enter: return Key.Enter;
					case XK_BackSpace: return Key.Backspace;
					case XK_Tab: return Key.Tab;
					case XK_Prior: return Key.PageUp;
					case XK_Next: return Key.PageDown;
					case XK_End: return Key.End;
					case XK_Home: return Key.Home;
					case XK_Insert: return Key.Insert;
					case XK_Delete: return Key.Delete;
					case XK_KP_Add: return Key.Add;
					case XK_KP_Subtract: return Key.Subtract;
					case XK_KP_Multiply: return Key.Multiply;
					case XK_KP_Divide: return Key.Divide;
					case XK_Pause: return Key.Pause;
					case XK_Left: return Key.Left;
					case XK_Right: return Key.Right;
					case XK_Up: return Key.Up;
					case XK_Down: return Key.Down;
					default:
						if (code >= XK_F1 && code <= XK_F12)
							return cast(key_t)(key_t.F1 + (code - XK_F1));
						else if (code >= XK_KP_0 && code <= XK_KP_9)
							return cast(key_t)(key_t.Numpad0 + (code - XK_KP_0));
						else if (code >= 'A' && code <= 'Z')
							return cast(key_t)(key_t.A + (code - 'A'));
						else if (code >= '0' && code <= '9')
							return cast(key_t)(key_t.Num0 + (code - '0'));
						break;
				}
				return Key.Unknown;
			}
		}
	}
}