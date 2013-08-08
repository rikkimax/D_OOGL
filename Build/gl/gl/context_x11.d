module gl.gl.context_x11;
import gl.gl.context;
//import gl.platform;

import derelict.opengl3.gl3;

version(Posix) {
	import core.sys.posix.sys.time;
	import deimos.X11.Xlib;
	import derelict.opengl3.glx;
	import derelict.opengl3.glxext : glXSwapIntervalSGI;
	import derelict.util.xtypes : XVisualInfo;

	extern(C) {
		alias int function(Display*, XErrorEvent*) XERRORHANDLER;

		int XErrorSurpressor(Display* display, XErrorEvent* ev) {
			return 0;
		}
	}

	class X11Context : ContextDef {
		this() {
			owned = false;

			glGetIntegerv(GL_VIEWPORT, defaultViewport.ptr);

			gettimeofday(&timeOffset, null);
		}

		this(ubyte color, ubyte depth, ubyte stencil, uint antialias, Display* display, int screen, GLXWindow window) {
			int[] pixelAttribs = [GLX_X_RENDERABLE, GL_TRUE,
			                            GLX_DRAWABLE_TYPE, GLX_WINDOW_BIT,
			                            GLX_DOUBLEBUFFER, GL_TRUE,
			                            GLX_RENDER_TYPE, GLX_RGBA_BIT,
			                            GLX_X_VISUAL_TYPE, GLX_TRUE_COLOR,
			                            GLX_BUFFER_SIZE, color,
			                            GLX_DEPTH_SIZE, depth,
			                            GLX_STENCIL_SIZE, stencil,
			                            GLX_SAMPLE_BUFFERS, antialias > 1 ? GL_TRUE : GL_FALSE,
			                            GLX_SAMPLES, antialias > 1 ? cast(int)antialias : 0
			                      ];
			
			int configCount;
			GLXFBConfig* configs = glXChooseFBConfig(cast(void*)display, screen, pixelAttribs.ptr, &configCount);
			if (configCount == 0) 
				throw new PixelFormatException();
			GLXFBConfig config = configs[0];

			XVisualInfo* vi = glXGetVisualFromFBConfig(display, config);

			/*const int[] attribs = [GLX_CONTEXT_MAJOR_VERSION_ARB, 3,
			                       GLX_CONTEXT_MINOR_VERSION_ARB, 2,
			                       GLX_CONTEXT_PROFILE_MASK_ARB, GLX_CONTEXT_CORE_PROFILE_BIT_ARB,
			                       0];*/
			
			XERRORHANDLER oldHandler = XSetErrorHandler(&XErrorSurpressor);

			context = glXCreateContext(display, vi, null, true);
			//context = glXCreateContextAttribsARB(display, config, null, true, attribs.ptr);

			XFree(configs);

			if (!context)
				throw new VersionException();

			XSetErrorHandler(oldHandler);

			glXMakeCurrent(display, window, context);

			this.display = display;
			this.glxWindow = window;
			this.owned = true;

			glGetIntegerv(GL_VIEWPORT, cast(int*)&defaultViewport);

			gettimeofday(&timeOffset, null);
		}

		~this() {
			if (!owned) return;

			glXMakeCurrent(display, 0, null);
			glXDestroyContext(display, context);
		}

		override void activate() {
			auto ret = glXGetCurrentContext();
			if (owned && glXGetCurrentContext() != context){
				glXMakeCurrent(cast(void*)display, glxWindow, context);
			}
		}

		void setVerticalSync(bool enabled) {
			glXSwapIntervalSGI(enabled ? 1 : 0);
		}

		override float time() {
			timeval time;
			gettimeofday(&time, null);

			return time.tv_sec - timeOffset.tv_sec +(time.tv_usec - timeOffset.tv_usec) / 1000000.0f;
		}
	}
}