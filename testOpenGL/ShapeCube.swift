//
//  shapeCube.swift
//  testOpenGL
//
//  Created by MacBook Pro on 20/06/2023.
//

import GLKit

class ShapeCube: ObjectModel {
//    let vertices:[Float] = [
//        //Front
//        1, -1, 1 ,  1, 0, 0, 1,
//        1, 1, 1 ,  1, 0, 0, 1,
//        -1, 1, 1 ,  0, 1, 0, 1,
//        -1, -1, 1 ,  0, 1, 0, 1,
//
//        //Back
//        -1, -1, -1 ,  1, 0, 0, 1,
//        -1, 1, -1 ,  1, 0, 0, 1,
//        1, 1, -1 ,  0, 1, 0, 1,
//        1, -1, -1 ,  0, 1, 0, 1,
//        ]
//    let indices:[UInt8] = [
//        //Front
//        0, 1, 2,
//        2, 3, 0,
//        // Back
//        4, 5, 6,
//        6, 7, 4,
//        //Left
//        3, 2, 5,
//        5, 4, 3,
//        // Right
//        7, 6, 1,
//        1, 0, 7,
//        // Top
//        1, 6, 5,
//        5, 2, 1,
//        // Bottom
//        3, 4,7,
//        7, 0, 3
//    ]
    
    //texture vertices
    let vertexList1 : [Float] = [
            
            // Front
             1, -1, 1,  1, 0, 0, 1,  1, 0, // 0
            1,  1, 1,  0, 1, 0, 1,  1, 1, // 1
            -1,  1, 1,  0, 0, 1, 1,  0, 1, // 2
            -1, -1, 1,  0, 0, 0, 1,  0, 0, // 3
            
            // Back
            -1, -1, -1, 0, 0, 1, 1,  1, 0, // 4
            -1,  1, -1, 0, 1, 0, 1,  1, 1, // 5
             1,  1, -1, 1, 0, 0, 1,  0, 1, // 6
             1, -1, -1, 0, 0, 0, 1,  0, 0, // 7
            
            // Left
            -1, -1,  1, 1, 0, 0, 1,  1, 0, // 8
            -1,  1,  1, 0, 1, 0, 1,  1, 1, // 9
            -1,  1, -1, 0, 0, 1, 1,  0, 1, // 10
            -1, -1, -1, 0, 0, 0, 1,  0, 0, // 11
            
            // Right
             1, -1, -1, 1, 0, 0, 1,  1, 0, // 12
             1,  1, -1, 0, 1, 0, 1,  1, 1, // 13
             1,  1,  1, 0, 0, 1, 1,  0, 1, // 14
             1, -1,  1, 0, 0, 0, 1,  0, 0, // 15
            
            // Top
             1,  1,  1, 1, 0, 0, 1,  1, 0, // 16
             1,  1, -1, 0, 1, 0, 1,  1, 1, // 17
            -1,  1, -1, 0, 0, 1, 1,  0, 1, // 18
            -1,  1,  1, 0, 0, 0, 1,  0, 0, // 19
            
            // Bottom
             1, -1, -1, 1, 0, 0, 1,  1, 0, // 20
             1, -1,  1, 0, 1, 0, 1,  1, 1, // 21
            -1, -1,  1, 0, 0, 1, 1,  0, 1, // 22
            -1, -1, -1, 0, 0, 0, 1,  0, 0, // 23
            
        ]
   
    let vertexList : [Vertex] = [
        
        // Front
        Vertex( 1, -1, 1,  1, 0, 0, 1,  1, 0), // 0
        Vertex( 1,  1, 1,  0, 1, 0, 1,  1, 1), // 1
        Vertex(-1,  1, 1,  0, 0, 1, 1,  0, 1), // 2
        Vertex(-1, -1, 1,  0, 0, 0, 1,  0, 0), // 3
        
        // Back
        Vertex(-1, -1, -1, 0, 0, 1, 1,  1, 0), // 4
        Vertex(-1,  1, -1, 0, 1, 0, 1,  1, 1), // 5
        Vertex( 1,  1, -1, 1, 0, 0, 1,  0, 1), // 6
        Vertex( 1, -1, -1, 0, 0, 0, 1,  0, 0), // 7
        
        // Left
        Vertex(-1, -1,  1, 1, 0, 0, 1,  1, 0), // 8
        Vertex(-1,  1,  1, 0, 1, 0, 1,  1, 1), // 9
        Vertex(-1,  1, -1, 0, 0, 1, 1,  0, 1), // 10
        Vertex(-1, -1, -1, 0, 0, 0, 1,  0, 0), // 11
        
        // Right
        Vertex( 1, -1, -1, 1, 0, 0, 1,  1, 0), // 12
        Vertex( 1,  1, -1, 0, 1, 0, 1,  1, 1), // 13
        Vertex( 1,  1,  1, 0, 0, 1, 1,  0, 1), // 14
        Vertex( 1, -1,  1, 0, 0, 0, 1,  0, 0), // 15
        
        // Top
        Vertex( 1,  1,  1, 1, 0, 0, 1,  1, 0), // 16
        Vertex( 1,  1, -1, 0, 1, 0, 1,  1, 1), // 17
        Vertex(-1,  1, -1, 0, 0, 1, 1,  0, 1), // 18
        Vertex(-1,  1,  1, 0, 0, 0, 1,  0, 0), // 19
        
        // Bottom
        Vertex( 1, -1, -1, 1, 0, 0, 1,  1, 0), // 20
        Vertex( 1, -1,  1, 0, 1, 0, 1,  1, 1), // 21
        Vertex(-1, -1,  1, 0, 0, 1, 1,  0, 1), // 22
        Vertex(-1, -1, -1, 0, 0, 0, 1,  0, 0), // 23
        
    ]
    
    let indexList : [GLubyte] = [
        
        // Front
        0, 1, 2,
        2, 3, 0,
        
        // Back
        4, 5, 6,
        6, 7, 4,
        
        // Left
        8, 9, 10,
        10, 11, 8,
        
        // Right
        12, 13, 14,
        14, 15, 12,
        
        // Top
        16, 17, 18,
        18, 19, 16,
        
        // Bottom
        20, 21, 22,
        22, 23, 20
    ]
         
    
    init(shader: ShaderUtility) {
        super.init(shader: shader, vertices: vertexList, indices: indexList)
        self.loadTexture(Bundle.main.path(forResource: "img.png", ofType: nil)!)
    }
    func updateWithDelta(delta:TimeInterval){
        self.rotationZ += Float(Double.pi*delta)
        self.rotationY += Float(Double.pi*delta)
    }
}

enum VertexAttributes : GLuint {
    case position = 0
    case color = 1
    case texCoord = 2
}

struct Vertex {
    var x : GLfloat = 0.0
    var y : GLfloat = 0.0
    var z : GLfloat = 0.0
    
    var r : GLfloat = 0.0
    var g : GLfloat = 0.0
    var b : GLfloat = 0.0
    var a : GLfloat = 1.0
    
    var u : GLfloat = 0.0
    var v : GLfloat = 0.0
    
    
    init(_ x : GLfloat, _ y : GLfloat, _ z : GLfloat, _ r : GLfloat = 0.0, _ g : GLfloat = 0.0, _ b : GLfloat = 0.0, _ a : GLfloat = 1.0, _ u : GLfloat = 0.0, _ v : GLfloat = 0.0) {
        self.x = x
        self.y = y
        self.z = z
        
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        
        self.u = u
        self.v = v
    }
}
