//
//  OpenGLView2.swift
//  testOpenGL
//
//  Created by MacBook Pro on 07/06/2023.
//
import OpenGLES
import GLKit


class OpenGLView2: GLKViewController,GLKViewControllerDelegate {
    
    private var square:ShapeSquare!
    private var cube:ShapeCube!
//    private var shader:ShaderUtility!
    override func viewDidLoad(){
        super.viewDidLoad()
        let gv = self.view as! GLKView
        gv.drawableDepthFormat = .format16
        gv.context = EAGLContext(api:EAGLRenderingAPI.openGLES3)!
      
       
       
    }
   
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        let shader = ShaderUtility(v_shaderFile: Bundle.main.url(forResource: "vertex_shader.glsl", withExtension: nil)!, f_shaderFile: Bundle.main.url(forResource: "fragment_shader.glsl", withExtension: nil)!,attributes: ["a_Position","a_Color","a_TexCoord"])
//        square = .init(shader: shader)
        cube = .init(shader: shader)
        shader.pjectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85), Float(view.bounds.size.width / view.bounds.size.height), 1, 150)
        delegate = self
        
      
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        glUseProgram(GLuint(0))
    }
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(1.0, 0.0, 0.0, 1.0);
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        
        glEnable(GLenum(GL_DEPTH_TEST))
        glEnable(GLenum(GL_CULL_FACE))
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        cube?.renderWithParentMoelViewMatrix(GLKMatrix4MakeTranslation(0, 0, -5))
        logError()
    }
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        cube.updateWithDelta(delta: timeSinceLastUpdate)
    }
    
    
    func logError() {
        while case let error = glGetError(), error != UInt32(GL_NO_ERROR) {
            print("GL_ER_LOG = ",error)
        }
    }
}
