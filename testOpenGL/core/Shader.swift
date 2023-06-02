//
//  Shader.swift
//  testOpenGL
//
//  Created by MacBook Pro on 02/06/2023.
//

import OpenGLES

class Shader {
    private(set) var rendererId:UInt32 = 0
    private var colorLocation:Int32 = -1
    private var textureLocation:Int32 = -1
//    private var uniformLocations:[String:Int32] = [:]
    init(VertextShaderURL vs:URL,FragementShaderURL fs:URL) {
        self.rendererId = createProgram(VertextShaderURL: vs, FragementShaderURL: fs)
        
    }
    deinit{
        glDeleteProgram(rendererId)
    }
    func createShader(shaderPath:URL,type:UInt32) -> UInt32 {
        let shaderId = glCreateShader(type)
        let ss = try! NSString(contentsOf: shaderPath, encoding: String.Encoding.utf8.rawValue)
        var shaderStringLegth:GLint = GLint(ss.length)
        var cString = ss.cString(using: String.Encoding.utf8.rawValue)
        
        glShaderSource(shaderId, GLsizei(1), &cString, &shaderStringLegth)
        glCompileShader(shaderId)
        
        var result:Int32 = 0
        glGetShaderiv(shaderId,GLenum(GL_COMPILE_STATUS),&result)
        if result == GL_FALSE{
            var len:Int32 = 0
            glGetShaderiv(shaderId, GLenum(GL_INFO_LOG_LENGTH), &len)
            let info =  UnsafeMutablePointer<CChar>.allocate(capacity: Int(len))
            glGetShaderInfoLog(shaderId, len, &len,info)
            print("Error in \(type == GL_VERTEX_SHADER ? "VERTEX_SHADER" : "FRAGMENT_SHADER") : ",String(cString: info))
            info.deinitialize(count: Int(len)).deallocate()
            glDeleteShader(shaderId)
            return 0
        }
        return shaderId
    }
    func createProgram(VertextShaderURL vs:URL,FragementShaderURL fs:URL)->UInt32 {
        let programId:UInt32 = glCreateProgram()
        let vs = createShader(shaderPath:vs, type: UInt32(GL_VERTEX_SHADER))
        let fs = createShader(shaderPath: fs, type: UInt32(GL_FRAGMENT_SHADER))
        
        glAttachShader(programId, vs)
        glAttachShader(programId, fs)
        glLinkProgram(programId)
        
        glDeleteShader(vs)
        glDeleteShader(fs)
        return programId
    }
    func setUniformTexture1f(v:Float) {
        glUniform1f(textureLocation,v)
    }
    func setUniformTextureLocation(name:String){
        textureLocation = glGetUniformLocation(rendererId, name)
    }
    
    func setUniform4f(v0:Float,v1:Float,v2:Float,v3:Float) {
        
        glUniform4f(colorLocation,v0, v1, v2, v3)
    }
    func setUniformLocation(name:String){
        colorLocation = glGetUniformLocation(rendererId, name)
    }
    
    func bind() {
        glUseProgram(rendererId)
    }
    func unBind() {
        glUseProgram(0)
    }
    func logError() {
        while case let error = glGetError(), error != UInt32(GL_NO_ERROR) {
            print("GL_ER_LOG = ",error)
        }
    }
}
