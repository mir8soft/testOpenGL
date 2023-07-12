//
//  ShapeSquare.swift
//  testOpenGL
//
//  Created by MacBook Pro on 20/06/2023.
//

import GLKit
import OpenGLES

class ShapeSquare: ObjectModel {
    private var vertics:[Float] = [
        -0.5,0.5,0, 0,1,0,1.0, // top left
         -0.5,-0.5,0, 0,0,1,1.0, //bottom left
         0.5,-0.5,0,  0.5,0,0,1.0, //bottom right

         //-0.5,0.5, // top left
          0.5,0.5,0, 1,0.0,0.0,1.0, //top right
         // 0.6,-0.5, //bottom right

    ]
//    private var indices:[GLubyte] = [
//        0,1,2,
//        0,3,2
//    ]
    init(shader: ShaderUtility) {
        super.init(shader: shader, vertices: [], indices: [])
//        super.init(shader: shader, vertices: &vertics, indices: &indices, verticesCount: vertics.count, indicesCount: indices.count)
    }
    
    func updateWithDelta(delta:Float){
        self.position = GLKVector3Make(sinf(Float(CACurrentMediaTime())*2*Float.pi) / 2, position.y, position.z)
    }
}
