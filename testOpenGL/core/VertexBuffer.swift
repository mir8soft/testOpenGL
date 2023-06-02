//
//  VertexBuffer.swift
//  testOpenGL
//
//  Created by MacBook Pro on 01/06/2023.
//

import OpenGLES

class VertexBuffer{
    private var renderId:UInt32 = 0
    init(data:UnsafeRawPointer,size:Int) {
        glGenBuffers(1, &renderId)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), renderId)
        glBufferData(GLenum(GL_ARRAY_BUFFER),size, data, GLenum(GL_STATIC_DRAW))
    }
    deinit {
         glDeleteBuffers(1, &renderId)
    }
    func bind() {
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.renderId)
    }
    func unBind() {
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
    }
}
