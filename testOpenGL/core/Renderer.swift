//
//  Renderer.swift
//  testOpenGL
//
//  Created by MacBook Pro on 02/06/2023.
//

import OpenGLES

struct Renderer {
    static func clear(){
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
    static func draw(vb:VertexBuffer,ib:IndexBuffer,shader:Shader) {
       shader.bind()
       vb.bind()
       ib.bind()
       glDrawElements(GLenum(GL_TRIANGLES), GLsizei(ib.indicesCount), GLenum(GL_UNSIGNED_BYTE), nil)
    }
}
