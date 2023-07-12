//
//  ShaderUtility.swift
//  testOpenGL
//
//  Created by MacBook Pro on 25/05/2023.
//

//import OpenGLES
import GLKit

class ShaderUtility {
    var texture:UInt32 = .init(0)
    var modelViewMatrix:GLKMatrix4 = GLKMatrix4Identity
    var pjectionMatrix:GLKMatrix4 = GLKMatrix4Identity
    private var modelMatrixUniformLocation = GLint(0)
    private var projectionMatrixUniformLocation = GLint(0)
    private var textureUnidorm = GLint(0)
    private var programId = GLuint(0)
    var attributes:[String:UInt32] = [:]
    func bindProgram() {
        glUseProgram(programId)
        glUniformMatrix4fv(modelMatrixUniformLocation, GLsizei(1), GLboolean(GL_FALSE), modelViewMatrix.array)
        
        glUniformMatrix4fv(projectionMatrixUniformLocation, GLsizei(1), GLboolean(GL_FALSE), pjectionMatrix.array)
        
        glActiveTexture(GLenum(GL_TEXTURE1))
        glBindTexture(GLenum(GL_TEXTURE_2D), self.texture)
        glUniform1i(textureUnidorm, 1)
    }
    init(v_shaderFile:URL,f_shaderFile:URL,attributes attrbs:[String] = []) {
        let vs:GLuint = createShader(shaderType:GL_VERTEX_SHADER,shaderSourcePath: v_shaderFile)
        let fs:GLuint = createShader(shaderType:GL_FRAGMENT_SHADER,shaderSourcePath:f_shaderFile)
        self.programId = glCreateProgram()
        glAttachShader(self.programId, GLuint(vs))
        glAttachShader(self.programId, GLuint(fs))
        
        attrbs.enumerated().forEach({ i,name in
            glBindAttribLocation(programId, GLuint(i), name)
            attributes[name] = UInt32(i)
        })
        
        glLinkProgram(programId)
        
        modelMatrixUniformLocation = glGetUniformLocation(programId, "u_ModelViewMatrix")
        projectionMatrixUniformLocation = glGetUniformLocation(programId, "u_ProjectionMatrix")
        textureUnidorm = glGetUniformLocation(programId, "u_Texture")
        var isLinked:GLint = 0
        glGetProgramiv(programId, GLenum(GL_LINK_STATUS), &isLinked)
        if isLinked == GL_FALSE{
            var maxLeght:GLint = 0
            glGetProgramiv(programId, GLenum(GL_INFO_LOG_LENGTH), &maxLeght)
            
            let str = UnsafeMutablePointer<CChar>.allocate(capacity: .init(maxLeght))
            glGetProgramInfoLog(programId, GLsizei(maxLeght), &maxLeght, str)
            print(String(cString: str))
            str.deinitialize(count: Int(maxLeght)).deallocate()
        }
        glDeleteShader(vs)
        glDeleteShader(fs)
    }
    private func createShader(shaderType type:Int32,shaderSourcePath path:URL)->GLuint{
        let shaderId = glCreateShader(GLenum(type))
        let shader = try! NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
        var cs = shader.cString(using: String.Encoding.utf8.rawValue)
        var len = GLint(shader.length)
        
        glShaderSource(shaderId, GLsizei(1),&cs, &len)
        glCompileShader(shaderId)
        
        var status:GLint = 0
        glGetShaderiv(shaderId, GLenum(GL_COMPILE_STATUS), &status)
        if status == GL_FALSE{
            var maxLenght:GLuint = 0
            glGetShaderiv(shaderId, GLenum(GL_INFO_LOG_LENGTH), &maxLenght)
            let str = UnsafeMutablePointer<CChar>.allocate(capacity: Int(maxLenght))
            glGetShaderInfoLog(shaderId, GLsizei(512), nil, str)
            print("Shader \(path.lastPathComponent) Error : ",String(cString: str))
            str.deinitialize(count: Int(maxLenght)).deallocate()
            return 0
        }
        return shaderId
    }
}
