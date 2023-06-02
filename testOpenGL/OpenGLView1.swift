//
//  OpenGLView1.swift
//  testOpenGL
//
//  Created by MacBook Pro on 30/05/2023.
//

import GLKit

class OpenGLView1: GLKViewController,GLKViewControllerDelegate {
    
    private var vertices:[GLfloat] = [
        -0.5, -0.5, 0.0, 0.0, // 0
         0.5, -0.5, 1.0, 0.0,  // 1
         0.5,  0.5, 1.0, 1.0,   // 2
         
         // 0.5, 0.5, // 2
         -0.5, 0.5, 0.0, 1.0,  //3
         //-0.5, -0.5 //0
    ]
    private var indeces:[GLubyte] = [
        0,1,2,
        2,3,0
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = self.view as! GLKView
        v.context = EAGLContext(api: EAGLRenderingAPI.openGLES3)!
        EAGLContext.setCurrent(v.context)
        delegate = self
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        vb = nil
        ib = nil
        va = nil
        layout = nil
        shader = nil
    }
    private var vb:VertexBuffer! = nil
    private var ib:IndexBuffer! = nil
    private var va:VertextArray! = nil
    private var layout:VertexBufferLayout! = nil
    private var shader:Shader! = nil
    private var texture:Texture! = nil
    
    func onAppear() {
        print(String(cString:  glGetString(GLenum(GL_VERSION))!))
        
//        glGenVertexArrays(1, &vertexBufferId)
//        glBindVertexArray(vertexBufferId)
        
        va = VertextArray()
        vb =  VertexBuffer(data: vertices, size: MemoryLayout<Float>.size*vertices.count)
        
        layout = VertexBufferLayout()
        layout.push(count: 2)
        layout.push(count: 2)
        va.addBuffer(vb: vb, layout: layout)
        
//        glEnableVertexAttribArray(GLuint(0))
//        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE),GLsizei(MemoryLayout.stride(ofValue: vertices)), nil)
        
        ib = IndexBuffer(data: indeces, count: indeces.count)
        
        
        shader = .init(VertextShaderURL: Bundle.main.url(forResource: "vertex_shader.glsl", withExtension: nil)!, FragementShaderURL: Bundle.main.url(forResource: "fragment_shader.glsl", withExtension: nil)!)
        shader.bind()
        shader.setUniformLocation(name: "u_color")
        shader.setUniform4f(v0: 1, v1: 0, v2: 0, v3: 1)
        
        //Texture load
        texture = .init(imageUrl:Bundle.main.url(forResource: "mck", withExtension: "png")!)
        texture.bind()
        shader.setUniformLocation(name: "u_texture")
        shader.setUniformTexture1f(v: 0)
        //unbind current object
//        va.unBind()
        shader.unBind()
        vb.unBind()
        ib.unBind()
//        glUseProgram(GLuint(0))
//        glBindBuffer(GLenum(GL_ARRAY_BUFFER), GLuint(0))
//        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), GLuint(0))
        glClearColor(0.3, 1, 0.4, 1)
    }
    private var vertexBufferId:UInt32 = 0
    private var programId:UInt32 = 0
//    private  var bufferId:UInt32 = 0
//    private var indexBufferId:UInt32 = 0
    
    var location:Int32 = 0
    var rc:Float = 0.0
    var inc:Float = 0.05
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        Renderer.clear()
        shader.setUniform4f(v0: rc, v1: 0, v2: 0, v3: 1)

        Renderer.draw(vb: self.vb, ib: self.ib, shader: self.shader)

        if rc > 1.0{
            inc = -0.01
        }else if rc < 0.0{
            inc = 0.01
        }
        rc += inc

    }

    
}
