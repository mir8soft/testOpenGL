//
//  VertextArray.swift
//  testOpenGL
//
//  Created by MacBook Pro on 01/06/2023.
//

import OpenGLES

class VertextArray {
    private var rendererId:GLuint = 0
    init() {
        glGenVertexArrays(1, &rendererId)
        
    }
    deinit {
        glDeleteVertexArrays(1, &rendererId)
    }
    func addBuffer(vb:VertexBuffer,layout:VertexBufferLayout) {
        bind()
        vb.bind()
        var offset:UInt = 0
        for i in 0..<layout.elements.count {
            glEnableVertexAttribArray(UInt32(i))
            glVertexAttribPointer(UInt32(i), GLint(layout.elements[i].count), GLenum(layout.elements[i].type), layout.elements[i].normalized,GLsizei(layout.stride), nil)
            offset += UInt(layout.elements.count) * VertextBufferElement.getSizeOfType(type:Int32(layout.elements[i].type))
        }
    }
    func bind() {
        glBindVertexArray(rendererId)
    }
    func unBind() {
        glBindVertexArray(0)
    }
    func BUFFER_OFFSET(_ n: Int) -> UnsafeRawPointer {
            let ptr: UnsafeRawPointer? = nil
            return ptr! + n * MemoryLayout<Void>.size
    }
}
