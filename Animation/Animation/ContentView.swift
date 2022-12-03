//
//  ContentView.swift
//  Animation
//
//  Created by Enrico Sousa Gollner on 30/11/22.
//

import SwiftUI

struct ContentView: View{
    @State private var animationAmount = 1.0
    
    var body: some View{
        Button("Tap me"){
            
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(.easeOut(duration: 1)
                    .repeatForever(autoreverses: false), value: animationAmount)
        )
        .onAppear{
            animationAmount = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
