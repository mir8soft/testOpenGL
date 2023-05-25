//
//  ContentView.swift
//  testOpenGL
//
//  Created by MacBook Pro on 25/05/2023.
//

import SwiftUI

struct ContentView: View {
    let glView =  OpenGLView(frame: .zero)
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            KitView(v:glView)
        }
        .padding()
        .onAppear{
            DispatchQueue.main.async {
                glView.onAppear()
            }
        }
    }
}

struct KitView:UIViewRepresentable {
    let v:OpenGLView
    func makeUIView(context: Context) -> OpenGLView {
       v
    }
    func updateUIView(_ uiView: OpenGLView, context: Context) {
     
    }
}
