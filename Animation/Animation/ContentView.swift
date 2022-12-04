//
//  ContentView.swift
//  Animation
//
//  Created by Enrico Sousa Gollner on 30/11/22.
//

import SwiftUI

struct ContentView: View{
    @State private var animationAmountImp = 1.0
    @State private var animationAmountExp = 0.0
    
    @State private var enabled = false
    
    var body: some View{
        VStack{
            Spacer()
            
            // Implicit:
            Button("Tap me"){
                
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .opacity(2 - animationAmountImp)
                    .scaleEffect(animationAmountImp)
                    .animation(.easeOut(duration: 1)
                        .repeatForever(autoreverses: false), value: animationAmountImp)
            )
            .onAppear{
                animationAmountImp = 2
            }
            
            Spacer()
            
            // Explicit:
            Button("Tap Me"){
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
                    animationAmountExp += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmountExp), axis: (x: 0, y: 1, z: 0))
            
            Spacer()
            
            // Controlling the animation stack
            Button("Tap Me"){
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .animation(nil, value: enabled)  // With nil, we disable that animation
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
            
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
