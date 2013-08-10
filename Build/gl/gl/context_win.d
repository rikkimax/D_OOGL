module gl.gl.context_win;
import gl.gl.context;
import gl.platform;

version(Windows) {
	class WinContext : ContextDef {

		this() {
			owned = false;

			glGetIntegerv(GL_VIEWPORT, defaultViewport.ptr);

			QueryPerformanceCounter(&timeOffset);
		}

		this(ubyte color, ubyte depth, ubyte stencil, uint antialias, HDC dc) {
			int[] pixelAttribs =
			[
				WGL_DRAW_TO_WINDOW_ARB, GL_TRUE,
				WGL_SUPPORT_OPENGL_ARB, GL_TRUE,
				WGL_DOUBLE_BUFFER_ARB, GL_TRUE,
				WGL_PIXEL_TYPE_ARB, WGL_TYPE_RGBA_ARB,
				WGL_COLOR_BITS_ARB, color,
				WGL_DEPTH_BITS_ARB, depth,
				WGL_STENCIL_BITS_ARB, stencil,
				WGL_SAMPLE_BUFFERS_ARB, antialias > 1 ? GL_TRUE : GL_FALSE,
				WGL_SAMPLES_ARB, antialias > 1 ? antialias : 0,
				0
			];
			SetPixelFormat(dc, PIXELFORMATDESCRIPTOR.sizeof, cast(PIXELFORMATDESCRIPTOR*)pixelAttribs.ptr);
			context = derelict.opengl3.wgl.wglCreateContext(dc);
			derelict.opengl3.wgl.wglMakeCurrent(dc, context);

			/*// Create dummy window
			HWND dummyWindow = CreateWindowA("STATIC\0", "\0", WS_POPUP | WS_DISABLED, 0, 0, 1, 1, null, null, GetModuleHandleA(null), null);
			HDC dummyDC = GetDC(dummyWindow);
			
			// Set dummy pixel format
			PIXELFORMATDESCRIPTOR dummyFormatDescriptor =
			{
				PIXELFORMATDESCRIPTOR.sizeof, 1, PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER,
					PFD_TYPE_RGBA, color, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, depth, stencil, 0, PFD_MAIN_PLANE,
					0, 0, 0, 0
			};
			
			int dummyPixelFormat = ChoosePixelFormat(dummyDC, &dummyFormatDescriptor);
			SetPixelFormat(dummyDC, dummyPixelFormat, &dummyFormatDescriptor);
			
			// Create dummy context
			HGLRC dummyContext = cast(HGLRC)derelict.opengl3.wgl.wglCreateContext(dummyDC);
			derelict.opengl3.wgl.wglMakeCurrent(dummyDC, dummyContext);
			
			int major, minor;
			glGetIntegerv(GL_MAJOR_VERSION, &major);
			glGetIntegerv(GL_MINOR_VERSION, &minor);
			if (major < 3 || (major == 3 && minor < 2)) throw new VersionException();
			
			// Choose final pixel format
			const int pixelAttribs[] =
			[
				WGL_DRAW_TO_WINDOW_ARB, GL_TRUE,
					WGL_SUPPORT_OPENGL_ARB, GL_TRUE,
					WGL_DOUBLE_BUFFER_ARB, GL_TRUE,
					WGL_PIXEL_TYPE_ARB, WGL_TYPE_RGBA_ARB,
					WGL_COLOR_BITS_ARB, color,
					WGL_DEPTH_BITS_ARB, depth,
					WGL_STENCIL_BITS_ARB, stencil,
					WGL_SAMPLE_BUFFERS_ARB, antialias > 1 ? GL_TRUE : GL_FALSE,
					WGL_SAMPLES_ARB, antialias > 1 ? antialias : 0,
					0
			];
			
			int pixelFormat;
			uint formatCount;
			wglChoosePixelFormatARB(dc, pixelAttribs.ptr, null, 1, &pixelFormat, &formatCount);
			if (formatCount == 0) throw new PixelFormatException();
			SetPixelFormat(dc, pixelFormat, &dummyFormatDescriptor);
			
			// Create OpenGL 3.2 context		
			int attribs[] = [
				WGL_CONTEXT_MAJOR_VERSION_ARB, 3,
					WGL_CONTEXT_MINOR_VERSION_ARB, 2,
					WGL_CONTEXT_PROFILE_MASK_ARB, WGL_CONTEXT_CORE_PROFILE_BIT_ARB,
					0
			];

			context = wglCreateContextAttribsARB(dc, null, attribs.ptr);
			
			// Clean up
			derelict.opengl3.wgl.wglMakeCurrent(dc, null);
			derelict.opengl3.wgl.wglDeleteContext(dummyContext);
			derelict.opengl3.wgl.wglMakeCurrent(dc, context);
			DestroyWindow(dummyWindow);
			
			this.dc = dc;
			this.owned = true;
			
			glGetIntegerv(GL_VIEWPORT, cast(GLint*)&defaultViewport);
			
			QueryPerformanceCounter(&timeOffset);*/
		}

		~this() {
			if (!owned) return;

			derelict.opengl3.wgl.wglMakeCurrent(dc, null);
			derelict.opengl3.wgl.wglDeleteContext(context);
		}

		public {
			override void activate(){
				if (owned && derelict.opengl3.wgl.wglGetCurrentContext() != context)
					derelict.opengl3.wgl.wglMakeCurrent(dc, context);
			}

			override void setVerticalSync(bool enabled) {
				wglSwapIntervalEXT(enabled ? 1 : 0);
			}

			override float time(){
				LARGE_INTEGER time, freq;
				QueryPerformanceCounter(&time);
				QueryPerformanceFrequency(&freq);
				
				return ((time.QuadPart - timeOffset.QuadPart) * 1000 / freq.QuadPart) / 1000.0f;
			}
		}
	}
}