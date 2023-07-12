//
//  OpenGLView.swift
//  testOpenGL
//
//  Created by MacBook Pro on 25/05/2023.
//

import GLKit
import OpenGLES

protocol UIConnectionDelegate{
    func onAppear()
}

class OpenGLView: GLKView,GLKViewDelegate {
    var uiDelegate: GLKViewDelegate? = nil
    private var shaderUtil:ShaderUtility!
    private var vertexBufferID:GLuint = 0
    private var indexBufferID:GLuint = 0
    private var vertics = [
        Vertex1(x: 0.3, y: -0.3, z: 0),
        Vertex1(x: 1, y: 1, z: 0),
        Vertex1(x: -1, y: 1, z: 0),
        Vertex1(x: -1, y: -1, z: 0)
    ]
    
    private var indexs:[GLubyte] = [
        0,1,2,
        2,3,0
    ]
    private let vertexPosion:GLuint = 0
    private let elemtentPosion:GLuint = 1
    private lazy var indexCount = {
        MemoryLayout.size(ofValue: indexs) /  MemoryLayout.size(ofValue: indexs[0])
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        context = EAGLContext.init(api: EAGLRenderingAPI.openGLES2)!
        delegate = self
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func onAppear() {
//        shaderUtil = .init(v_shaderFile: "vertex_shader.glsl", f_shaderFile: "fragment_shader.glsl")
//        loadTriangle()
        
        shaderUtil.bindProgram()
    }
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0, 1, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
     
        
        glEnableVertexAttribArray(vertexPosion)
        glVertexAttribPointer(vertexPosion, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE),GLsizei(MemoryLayout<Vertex>.stride),nil)
        
        glEnableVertexAttribArray(elemtentPosion)
        glVertexAttribPointer(elemtentPosion, 1, GLenum(GL_FLOAT), GLboolean(GL_FALSE),GLsizei(MemoryLayout<Vertex>.size),UnsafeRawPointer(bitPattern: 3*MemoryLayout<GLfloat>.stride))
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBufferID)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBufferID)
//        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indexCount), GLenum(GL_UNSIGNED_BYTE), &indexs)
        
        glDisableVertexAttribArray(vertexPosion)
    }
    private func loadTriangle(){
       
        
        glGenBuffers(GLsizei(1), &vertexBufferID)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBufferID)
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertics.count*MemoryLayout<Vertex>.size, vertics, GLenum(GL_STATIC_DRAW))
        
        glGenBuffers(GLsizei(1), &indexBufferID)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), GLuint(indexCount))
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), MemoryLayout.size(ofValue: indexs), indexs, GLenum(GL_STATIC_DRAW))
    }
}
