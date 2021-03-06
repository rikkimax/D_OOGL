D_OOGL
------

Port of OOGL (opengl OOP wrapper) in D. Original repo https://github.com/Overv/OOGL

## License
Boost, OOGL has been relicensed to Boost, so it is reflected here (although code has not been updated).

## Features that have been ported:

**gl.math**

* mat3 ported
* mat4 ported
* vec2 ported
* vec3 ported
* vec4 ported
* util ported

**util**
* gl.util.color has been ported fully
* gl.util.image has not been ported fully. Only interface
* gl.util.mesh has not been ported fully. Only interface.
* gl.util.bytebuffer not ported can be emulated with a dynamic array.

**window**
* gl.window.event ported fully.
* gl.window.window ported fully.
* gl.window.window_x11 ported fully.
* gl.window.window_win32 ported fully.

**gl**
* gl.gl.context ported fully.
* gl.gl.context_x11 ported fully.
* gl.gl.context_win32 ported fully.
* gl.gl.extensions not ported. Not required as of Derelict3.
* gl.gl.framebuffer ported fully.
* gl.gl.gc not ported. Caused issues with type system.
* gl.gl.program ported fully.
* gl.gl.renderbuffer ported fully.
* gl.gl.shader ported fully.
* gl.gl.texture ported fully.
* gl.gl.vertexarray ported fully.
* gl.gl.vertexbuffer ported fully.

**samples**
* triangle ported
* transformfeedback modified to reflect new class to handle it.
* stencilreflect not ported. needs mesh/image loading.
* shadowmapping not ported. needs mesh/image loading.

With reguards to mesh loading. The mesh loading mechanism that was originally there only loaded obj's. It should only support mesh being stored. An external lib should load the data into it.
Image loading required libjpeg and libpng. Again same with mesh loading it was removed. It still can be used for storing as mesh's are.

## Features that has been added

**gl**
* gl.gl.transformfeedback The existing implementation was buggy and incomplete. Added this to fix this issue. Added query capabilities on it as well.
* 

## Notes about compiling
Remember the snippet -L/SUBSYSTEM:WINDOWS for removing windows console.
Mac OSX has not been tested but should work as per posix if x server is installed.
64bit and 32bit should be compilable on Windows XP+ (tested on Windows 7) and Posix.
