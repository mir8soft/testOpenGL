//
//  IndexBuffer.swift
//  testOpenGL
//
//  Created by MacBook Pro on 01/06/2023.
//

import OpenGLES

class IndexBuffer{
    private var renderId:UInt32 = 0
    private(set) var indicesCount:Int = 0
    init(data:UnsafeRawPointer,count:Int) {
        self.indicesCount = count
        glGenBuffers(1, &renderId)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), renderId)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), MemoryLayout<UInt>.size*indicesCount, data, GLenum(GL_STATIC_DRAW))
    }
    deinit {
         glDeleteBuffers(1, &renderId)
        print("deleted beffer")
    }
    func bind() {
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), self.renderId)
    }
    func unBind() {
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    }
}
