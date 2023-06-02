//
//  VertexBufferLayout.swift
//  testOpenGL
//
//  Created by MacBook Pro on 01/06/2023.
//

import OpenGLES

struct VertextBufferElement {
    let count:UInt
    let type:Int32
    let normalized:UInt8
    static func getSizeOfType(type:Int32)->UInt{
        switch type{
        case GL_FLOAT,GL_UNSIGNED_INT:
            return 4
        case GL_UNSIGNED_BYTE:
            return 1
        default:
            return 0
        }
    }
}

class VertexBufferLayout{
    private(set) var elements:[VertextBufferElement] = []
    private(set) var stride:UInt = 0
//    func push<T>(count:T) {
//        
//    }
    func push(count:UInt) {
        elements.append(.init(count: count, type: GL_FLOAT, normalized: UInt8(GL_FALSE)))
        stride += count * VertextBufferElement.getSizeOfType(type: GL_UNSIGNED_INT)
    }
}
