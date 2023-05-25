//
//  OpenGLView.swift
//  testOpenGL
//
//  Created by MacBook Pro on 25/05/2023.
//

import GLKit

protocol UIConnectionDelegate{
    func onAppear()
}

class OpenGLView: GLKView,GLKViewDelegate {
    var uiDelegate: GLKViewDelegate? = nil
    private var shaderUtil:ShaderUtility!
    private var vertexBufferID:GLuint = 0
    private var indexBufferID:GLuint = 0
    private var vertics = [
        Vertex(x: 1, y: -1, z: 0),
        Vertex(x: 1, y: 1, z: 0),
        Vertex(x: -1, y: -1, z: 0)
    ]
    
    private let indexs:[GLubyte] = [
        0,1,2,
        2,3,0
    ]
    let indexCOunt = MemoryLayout<GLubyte>.size / MemoryLayout<Vertex>.size
    override init(frame: CGRect) {
        super.init(frame: frame)
        context = EAGLContext.init(api: EAGLRenderingAPI.openGLES2)!
        delegate = self
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func onAppear() {
        shaderUtil = .init(v_shaderFile: "vertex_shader.glsl", f_shaderFile: "fragment_shader.glsl")
        loadTriangle()
        
        shaderUtil.prepareToDraw()
    }
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0, 1, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
     
        
        glEnableVertexAttribArray(GLuint(0))
        glVertexAttribPointer(GLuint(0), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE),GLsizei(MemoryLayout<Vertex>.size),nil)
//        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBufferID)
//        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indexCOunt), GLenum(GL_UNSIGNED_BYTE), nil)
        
        glDisableVertexAttribArray(GLuint(0))
    }
    private func loadTriangle(){
        glGenBuffers(GLsizei(1), &indexBufferID)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), GLuint(indexCOunt))
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), MemoryLayout<GLubyte>.size, indexs, GLenum(GL_STATIC_DRAW))
        
        glGenBuffers(GLsizei(1), &vertexBufferID)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBufferID)
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertics.count*MemoryLayout<Vertex>.size, vertics, GLenum(GL_STATIC_DRAW))
    }
}
