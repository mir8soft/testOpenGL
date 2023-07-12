//
//  ContentView.swift
//  testOpenGL
//
//  Created by MacBook Pro on 25/05/2023.
//

import SwiftUI

struct ContentView: View {
    let glView =  OpenGLView2()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            KitView(v:glView)
        }
        .padding()
//        .onAppear{
//            DispatchQueue.main.async {
//                glView.onAppear()
//            }
//        }
    }
}

struct KitView:UIViewControllerRepresentable{
    let v:OpenGLView2
    func makeUIViewController(context: Context) -> OpenGLView2 {
        v
    }
    func updateUIViewController(_ uiViewController: OpenGLView2, context: Context) {
        
    }
}
