//
//  ShaderUtility.swift
//  testOpenGL
//
//  Created by MacBook Pro on 25/05/2023.
//

import OpenGLES

class ShaderUtility {
    var programId = GLuint(0)
    init(v_shaderFile:String,f_shaderFile:String) {
        self.compile(v_shader: v_shaderFile, f_shader: f_shaderFile)
    }
    func prepareToDraw() {
        glUseProgram(programId)
    }
   private func compile(v_shader:String,f_shader:String) {
        let vertexShaderID = self.compileShader(shader: v_shader, shader_type: GLenum(GL_VERTEX_SHADER))
        let fragmentShaderID = self.compileShader(shader: f_shader, shader_type: GLenum(GL_FRAGMENT_SHADER))
       self.programId = glCreateProgram()
       glAttachShader(self.programId, vertexShaderID)
       glAttachShader(self.programId, fragmentShaderID)
       
       glBindAttribLocation(programId, GLuint(0), "m_position")
       glLinkProgram(programId)
       
       var linkStatus = GLint(0)
       glGetProgramiv(programId, GLenum(GL_LINK_STATUS), &linkStatus)
       if linkStatus == GL_FALSE{
           var infoLenght = GLsizei(0)
           let bufferLenght = GLsizei(1024)
           glGetProgramiv(programId, GLenum(GL_INFO_LOG_LENGTH), &infoLenght)
           
           var info : [GLchar] = Array(repeating: GLchar(0), count: Int(bufferLenght))
           var actualLength = GLsizei(0)
           glGetProgramInfoLog(programId, bufferLenght, &actualLength, &info)
           print("Program compile error = ",String(validatingUTF8: info) ?? "")
           exit(1)
       }
        
    }
    private func compileShader(shader:String,shader_type:GLenum)->GLuint{
        let path = Bundle.main.url(forResource: shader, withExtension: nil)!
        let ss = try! NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
        let shadeHandle = glCreateShader(shader_type)
        var shaderStringLegth:GLint = GLint(ss.length)
        var cString = ss.cString(using: String.Encoding.utf8.rawValue)
        glShaderSource(shadeHandle, GLsizei(1), &cString, &shaderStringLegth)
        glCompileShader(shadeHandle)
        var compileStatus = GLint(0)
        glGetShaderiv(shadeHandle, GLenum(GL_COMPILE_STATUS), &compileStatus)
        if compileStatus == GL_FALSE{
            var infoLenghtSize = GLsizei(0)
            let bufferLength = GLsizei(1024)
            glGetShaderiv(shadeHandle, GLenum(GL_INFO_LOG_LENGTH), &infoLenghtSize)
            var info:[GLchar] = Array(repeating: GLchar(0), count: Int(bufferLength))
            var actualLength = GLsizei(0)
            glGetShaderInfoLog(shadeHandle, bufferLength, &actualLength,&info)
            print("error in :\n \(shader)\n Error = ",String(validatingUTF8: info) ?? "")
            exit(1)
        }
        return shadeHandle
    }
    
}
