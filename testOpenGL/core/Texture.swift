//
//  Texture.swift
//  testOpenGL
//
//  Created by MacBook Pro on 02/06/2023.
//

import OpenGLES
import CoreGraphics
import UIKit

class Texture {
    private var rendererId:UInt32 = 0
    private(set) var height:Int32 = 0,width:Int32 = 0,bit_per_pexil:UInt8 = 0
    init(imageUrl:URL) {
        var image:UIImage! = UIImage(data:try! .init(contentsOf: imageUrl))!
        let width = Int(image.size.width)
        let height = Int(image.size.height)
        
        let cs = CGColorSpaceCreateDeviceRGB()
        var imageData = [UInt8](repeating: 0, count: width*height)
        let context2 = CGContext(data: &imageData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4*width, space: cs, bitmapInfo:CGImageByteOrderInfo.order32Little.rawValue)!
//        context2.translateBy (x: 0, y: CGFloat(height))
//        context2.scaleBy (x: 1.0, y: -1.0);
//        context2.clear( CGRectMake( 0, 0, CGFloat(width), CGFloat(height) ) );
//        context2.translateBy( x: 0, y: CGFloat(width - height) );
        context2.draw( image.cgImage!, in: CGRectMake( 0, 0, CGFloat(width),CGFloat(height)))
        
        glGenTextures(1, &rendererId)
        glBindTexture(GLenum(GL_TEXTURE_2D), rendererId)
        
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GL_CLAMP_TO_EDGE)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GL_CLAMP_TO_EDGE)
        
        glTexImage2D(GLenum(GL_TEXTURE_2D), 0, GL_RGBA8, GLsizei(width),GLsizei(height),0, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), &imageData)
        glBindTexture(GLenum(GL_TEXTURE_2D), 0)
        image = nil
    }
    deinit {
       glDeleteTextures(1, &rendererId)
    }
    func bind(slot:UInt32 = 0) {
        glActiveTexture(GLenum(GL_TEXTURE0) + slot )
        glBindTexture(GLenum(GL_TEXTURE_2D), rendererId)
    }
    func unBind() {
        glBindTexture(GLenum(GL_TEXTURE_2D), 0)
    }
    
}
