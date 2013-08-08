D_OOGL
------

Port of OOGL (opengl OOP wrapper) in D. Original repo https://github.com/Overv/OOGL

## Features that have been ported:

**gl.math**

Ported all.

**util**
* gl.util.color has been ported fully
* gl.util.image has not been ported fully. Only interface
* gl.util.mesh has not been ported fully. Only interface.
* gl.util.bytebuffer not ported can be emulated with a dynamic array.

**window**
* gl.window.event ported fully.
* gl.window.window ported fully.
* gl.window.window_x11 ported fully.
* gl.window.window_win32 not ported.

**gl**
* gl.gl.context ported fully.
* gl.gl.context_x11 ported fully.
* gl.gl.context_win32 not ported.
* gl.gl.extensions not ported. Not required as of Derelict3.
* gl.gl.framebuffer ported fully.
* gl.gl.gc not ported. Caused issues with type system.
* gl.gl.program ported fully.
* gl.gl.renderbuffer not ported.
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
