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
    
    var body: some View{
        VStack{
            Spacer()
            
            // Implicit
            Button("Tap Me"){
                
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
                    .animation(.easeInOut(duration: 1)
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
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmountExp), axis: (x: 0, y: 1, z: 0))
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
