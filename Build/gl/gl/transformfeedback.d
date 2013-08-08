module gl.gl.transformfeedback;
import gl.gl.vertexbuffer;
import gl.gl.program;
import gl.gl.context;

import derelict.opengl3.gl3;

enum TransformTarget {
	SamplesPassed = GL_SAMPLES_PASSED,
	AnySamplesPassed = GL_ANY_SAMPLES_PASSED,
	AnySamplesPassedConservative = GL_ANY_SAMPLES_PASSED_CONSERVATIVE,
	PrimitivesGenerated = GL_PRIMITIVES_GENERATED,
	TransformFeedbackPrimitivesWritten = GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
	TimeElapsed = GL_TIME_ELAPSED
}

class TransformFeedback {
	private {
		uint obj;
		VertexBuffer vbo;
		Program program;
		Primitive primitiveType;
		uint qId;
	}

	this(size_t size, Program program, Primitive p, string[] varyings...) {
		this(new VertexBuffer(cast(uint)size, BufferUsage.StaticDraw), program, p, varyings);
	}

	this(VertexBuffer vbo, Program program, Primitive p, string[] varyings ...) {
		this.vbo = vbo;
		this.program = program;
		this.primitiveType = p;

		glGenTransformFeedbacks(1, &obj);
		glBindTransformFeedback(GL_TRANSFORM_FEEDBACK, obj);
		glBindBufferBase(GL_TRANSFORM_FEEDBACK_BUFFER, 0, vbo.id);
		glBindTransformFeedback(GL_TRANSFORM_FEEDBACK, 0);

		program.transformFeedbackVaryings(varyings);

		glGenQueries(1, &qId);
	}

	@property uint id() {
		return obj;
	}

	@property VertexBuffer buffer() {
		return vbo;
	}

	void begin() {
		glEnable(Capability.RasterizerDiscard);
		glUseProgram(program.id);
		glBindTransformFeedback(GL_TRANSFORM_FEEDBACK, obj);
		glBeginTransformFeedback(primitiveType);
	}

	void end() {
		glEndTransformFeedback();
		glUseProgram(0);
		glDisable(Capability.RasterizerDiscard);

		glDrawTransformFeedback(primitiveType, vbo.id);
	}

	void beginQuery(TransformTarget target) {
		glBeginQuery(target, qId);
	}

	int endQuery() {
		glEndQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
		int ret;
		glGetQueryObjectiv(qId, GL_QUERY_RESULT, &ret);
		return ret;
	}
}