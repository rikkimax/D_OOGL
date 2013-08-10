module gl.window.window_win;
import gl.window.window;
import gl.window.event;
import gl.gl.context;
import gl.platform;

version(Windows) {
	Window[size_t] windows;

	class WinWindow : WindowDef {
		this(uint width = 800, uint height = 600, string title = "Window", window_style_t style = window_style_t.Close) {
			static size_t windowCount;
			windowId = windowCount;
			windowCount++;
			windows[windowId] = this;

			string appName = "OOGL_WINDOW";
			HWND hwnd;
			MSG  msg;
			WNDCLASSA wndclass;

			wndclass.style         = CS_HREDRAW | CS_VREDRAW;
			wndclass.lpfnWndProc   = &windowEventHandler;
			wndclass.cbClsExtra    = 0;
			wndclass.cbWndExtra    = 0;
			wndclass.hInstance     = GetModuleHandleA(null);//hInstance;
			wndclass.hIcon         = LoadIconA(NULL, IDI_APPLICATION);
			wndclass.hCursor       = LoadCursorA(NULL, IDC_ARROW);
			wndclass.hbrBackground = cast(HBRUSH)GetStockObject(WHITE_BRUSH);
			wndclass.lpszMenuName  = NULL;
			wndclass.lpszClassName = appName.ptr;

			if(!RegisterClassA(&wndclass))
			{
				MessageBoxA(NULL, "This program requires Windows NT!", appName.ptr, MB_ICONERROR);
				return;
			}

			// Configure window style
			ulong windowStyle = WS_CAPTION | WS_MINIMIZEBOX | WS_VISIBLE;
			if (style & WindowStyle.Close) windowStyle |= WS_SYSMENU;
			if (style & WindowStyle.Resize) windowStyle |= WS_SYSMENU | WS_THICKFRAME | WS_MAXIMIZEBOX;

			hwnd = CreateWindowA(appName.ptr,      // window class name
			                    title.ptr,  // window caption
			                    cast(uint)windowStyle,  // window style
			                    CW_USEDEFAULT,        // initial x position
			                    CW_USEDEFAULT,        // initial y position
			                    width,        // initial x size
			                    height,        // initial y size
			                    NULL,                 // parent window handle
			                    NULL,                 // window menu handle
			                    GetModuleHandleA(NULL),            // program instance handle
			                    cast(void*)windowId);                // creation parameters
			
			int x = 0;
			int y = 0;
			
			if (!(style & WindowStyle.Fullscreen))
			{
				// Calculate window size for requested client size
				RECT rect = {0, 0, width, height};
				AdjustWindowRect(&rect, cast(uint)windowStyle, cast(int)false);
				width = cast(uint)(rect.right - rect.left);
				height = cast(uint)(rect.bottom - rect.top);
				
				// Center window on screen
				GetClientRect(GetDesktopWindow(), &rect);
				x = cast(uint)(rect.right - rect.left - width) / 2;
				y = cast(uint)(rect.bottom - rect.top - height) / 2;
			}

			RECT rect;
			GetWindowRect(window, &rect);
			
			this.x = cast(uint)rect.left;
			this.y = cast(uint)rect.top;
			
			this.width = cast(uint)(rect.right - rect.left);
			this.height = cast(uint)(rect.bottom - rect.top);
			this.open = true;
			this.style = cast(uint)windowStyle;
			this.mousex = 0;
			this.mousey = 0;
			this.mouse = 0;
			this.keys = 0;
			this.context = null;
		}

		~this() {
			DestroyWindow(window);
			
			UnregisterClassA("OGL_WINDOW", GetModuleHandleA(null));

			windows[windowId] = null;
		}

		public {
			override void setPos(int x, int y) {
				if (!open) return;
				SetWindowPos(window, null, x, y, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
			}

			override void setSize(uint width, uint height) {
				if (!open) return;
				RECT rect = {0, 0, width, height};
				AdjustWindowRect(&rect, style, false);
				SetWindowPos(window, NULL, 0, 0, cast(uint)(rect.right - rect.left), cast(uint)(rect.bottom - rect.top), SWP_NOMOVE | SWP_NOZORDER);
			}
			
			override void setTitle(string title) {
				if (!open) return;
				SetWindowTextA(window, (title ~ 0).ptr);
			}
			
			override void setVisible(bool visible) {
				if (!open) return;
				ShowWindow(window, visible ? SW_SHOW : SW_HIDE);
			}
			
			override void close() {
				if (open)
					CloseWindow(window);
				open = false;
			}
			
			override bool getEvent(ref Event ev) {
				// Fetch new events
				MSG msg;
				while (PeekMessageA(&msg, NULL, 0, 0, PM_REMOVE))
				{
					TranslateMessage(&msg);
					DispatchMessageA(&msg);
				}
				
				// Return oldest event - if available
				if (events.length == 0) return false;
				
				ev = events[0];
				if (events.length > 1)
					events = events[1 .. $];
				else
					events.length = 0;

				return true;
			}

			override ref gl.gl.context.Context getContext(ubyte color = 32, ubyte depth = 24, ubyte stencil = 8, ubyte antialias = 1) {
				if (context)
					return context;
				else {
					context = new Context(color, depth, stencil, antialias, GetDC(window));
					DerelictGL3.reload();
					return context;
				}
			}

			override void present() {
				if (!context) return;
				context.activate();
				SwapBuffers(GetDC(window));
			}
			
			override void forceUpdate() {
				if (!context) return;
				SwapBuffers(GetDC(window));
			}
		}

		protected {
			override LRESULT windowEvent(uint msg, WPARAM wParam, LPARAM lParam) {
				Event ev;
				ev.type = event_t.Unknown;
				
				// Translate message to Event
				switch (msg)
				{
					case WM_CLOSE:
						close();
						ev.type = event_t.Close;
						break;
						
					case WM_SIZE:
						width = LOWORD(lParam);
						height = HIWORD(lParam);

						if (events.length == 0) {
							ev.type = event_t.Resize;
							ev.window.width = width;
							ev.window.height = height;
						} else if (events[$-1].type == event_t.Resize) {
							events[$-1].window.width = width;
							events[$-1].window.height = height;
						}
						break;
						
					case WM_MOVE:
						RECT rect;
						GetWindowRect(window, &rect);
						x = cast(uint)rect.left;
						y = cast(uint)rect.top;
						
						if (events.length == 0) {
							ev.type = event_t.Move;
							ev.window.x = x;
							ev.window.y = y;
						} else if (events[$-1].type == event_t.Move) {
							events[$-1].window.x = x;
							events[$-1].window.y = y;
						}
						break;
						
					case WM_ACTIVATE:
						if (wParam == WA_INACTIVE) {
							ev.type = event_t.Blur;
							focus = false;
						} else {
							ev.type = event_t.Focus;
							focus = true;
						}
						break;
						
					case WM_KEYDOWN:
					case WM_SYSKEYDOWN:
						ev.type = event_t.KeyDown;
						ev.key.code = translateKey(cast(uint)wParam);
						ev.key.alt = HIWORD(GetAsyncKeyState(VK_MENU)) != 0;
						ev.key.control = HIWORD(GetAsyncKeyState(VK_CONTROL)) != 0;
						ev.key.shift = HIWORD(GetAsyncKeyState(VK_SHIFT)) != 0;
						
						keys[ev.key.code] = true;
						break;
						
					case WM_KEYUP:
					case WM_SYSKEYUP:
						ev.type = event_t.KeyUp;
						ev.key.code = translateKey(cast(uint)wParam);
						ev.key.alt = HIWORD(GetAsyncKeyState(VK_MENU)) != 0;
						ev.key.control = HIWORD(GetAsyncKeyState(VK_CONTROL)) != 0;
						ev.key.shift = HIWORD(GetAsyncKeyState(VK_SHIFT)) != 0;
						
						keys[ev.key.code] = false;
						break;
						
					case WM_LBUTTONDOWN:
					case WM_RBUTTONDOWN:
					case WM_MBUTTONDOWN:
						mousex = LOWORD(lParam);
						mousey = HIWORD(lParam);
						
						if (msg == WM_LBUTTONDOWN) ev.mouse.button = MouseButton.Left;
						else if (msg == WM_RBUTTONDOWN) ev.mouse.button = MouseButton.Right;
						else if (msg == WM_MBUTTONDOWN) ev.mouse.button = MouseButton.Middle;
						else break;
						
						ev.type = event_t.MouseDown;
						ev.mouse.x = mousex;
						ev.mouse.y = mousey;
						
						mouse[ev.mouse.button] = true;
						break;
						
					case WM_LBUTTONUP:
					case WM_RBUTTONUP:
					case WM_MBUTTONUP:
						mousex = LOWORD(lParam);
						mousey = HIWORD(lParam);
						
						if (msg == WM_LBUTTONUP) ev.mouse.button = MouseButton.Left;
						else if (msg == WM_RBUTTONUP) ev.mouse.button = MouseButton.Right;
						else if (msg == WM_MBUTTONUP) ev.mouse.button = MouseButton.Middle;
						else break;
						
						ev.type = event_t.MouseUp;
						ev.mouse.x = mousex;
						ev.mouse.y = mousey;
						
						mouse[ev.mouse.button] = false;
						break;
						
					case WM_MOUSEWHEEL:
						mousex = LOWORD(lParam);
						mousey = HIWORD(lParam);

						ev.type = event_t.MouseWheel;
						ev.mouse.delta = GET_WHEEL_DELTA_WPARAM(wParam) > 0 ? 1 : -1;
						ev.mouse.x = mousex;
						ev.mouse.y = mousey;
						break;
						
					case WM_MOUSEMOVE:
						mousex = LOWORD(lParam);
						mousey = HIWORD(lParam);
						
						ev.type = event_t.MouseMove;
						ev.mouse.x = mousex;
						ev.mouse.y = mousey;
						break;
						
					default:
						return DefWindowProcA(this.window, msg, wParam, lParam);
				}
				
				// Add event to internal queue
				if (ev.type != event_t.Unknown)
					events[] = ev;

				return 0;
			}

			extern(Windows) static LRESULT windowEventHandler(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
				Window window;
				import std.stdio;
				switch (message)
				{
					case WM_CREATE:
						window = windows[cast(size_t)((cast(LPCREATESTRUCTA)lParam).lpCreateParams)];
						window.window = hwnd;
						SetWindowLongA(hwnd, GWL_USERDATA, cast(size_t)window.windowId);
						assert(cast(size_t)(GetWindowLongA(hwnd, GWL_USERDATA)) == window.windowId);
						return 0;
					case WM_DESTROY:
						PostQuitMessage(0);
						return 0;
					default:
						window = windows[cast(size_t)(GetWindowLongA(hwnd, GWL_USERDATA))];
						window.window = hwnd;
						assert(window.windowId == cast(size_t)(GetWindowLongA(hwnd, GWL_USERDATA)));
						return window.windowEvent(cast(uint)message, cast(uint)wParam, cast(uint)lParam);
						break;
				}
				
				return DefWindowProcA(hwnd, message, wParam, lParam);
			}

			override key_t translateKey(uint code) {
				switch (code)
				{
					case VK_SHIFT: return Key.Shift;
					case VK_MENU: return Key.Alt;
					case VK_CONTROL: return Key.Control;
					case VK_OEM_1: return Key.Semicolon;
					case VK_OEM_2: return Key.Slash;
					case VK_OEM_PLUS: return Key.Equals;
					case VK_OEM_MINUS: return Key.Hyphen;
					case VK_OEM_4: return Key.LeftBracket;
					case VK_OEM_6: return Key.RightBracket;
					case VK_OEM_COMMA: return Key.Comma;
					case VK_OEM_PERIOD: return Key.Period;
					case VK_OEM_7: return Key.Quote;
					case VK_OEM_5: return Key.Backslash;
					case VK_OEM_3: return Key.Tilde;
					case VK_ESCAPE: return Key.Escape;
					case VK_SPACE: return Key.Space;
					case VK_RETURN: return Key.Enter;
					case VK_BACK: return Key.Backspace;
					case VK_TAB: return Key.Tab;
					case VK_PRIOR: return Key.PageUp;
					case VK_NEXT: return Key.PageDown;
					case VK_END: return Key.End;
					case VK_HOME: return Key.Home;
					case VK_INSERT: return Key.Insert;
					case VK_DELETE: return Key.Delete;
					case VK_ADD: return Key.Add;
					case VK_SUBTRACT: return Key.Subtract;
					case VK_MULTIPLY: return Key.Multiply;
					case VK_DIVIDE: return Key.Divide;
					case VK_PAUSE: return Key.Pause;
					case VK_LEFT: return Key.Left;
					case VK_RIGHT: return Key.Right;
					case VK_UP: return Key.Up;
					case VK_DOWN: return Key.Down;
						
					default:
						if (code >= VK_F1 && code <= VK_F12)
							return cast(Key)(Key.F1 + code - VK_F1);
						else if (code >= VK_NUMPAD0 && code <= VK_NUMPAD9)
							return cast(Key)(Key.Numpad0 + code - VK_NUMPAD0);
						else if (code >= 'A' && code <= 'Z')
							return cast(Key)(Key.A + code - 'A');
						else if (code >= '0' && code <= '9')
							return cast(Key)( Key.Num0 + code - '0');
				}
				
				return Key.Unknown;
			}
		}
	}
}