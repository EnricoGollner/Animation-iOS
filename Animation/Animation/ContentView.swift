//
//  ContentView.swift
//  Animation
//
//  Created by Enrico Sousa Gollner on 30/11/22.
//

import SwiftUI

struct ContentView: View{
    
    @State private var isShowingRed = false
    
    let letters = Array("Hello, SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    @State private var animationAmountImp = 1.0
    @State private var animationAmountExp = 0.0
    
    var body: some View{
        VStack{
            Spacer()
            
            Button(isShowingRed ? "Hide rectangle" : "Show rectangle"){
                withAnimation{
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
            Spacer()
            
            HStack(spacing: 0){
                ForEach(0..<letters.count){ num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .foregroundColor(.white)
                        .offset(dragAmount)
                        .animation(.default
                            .delay(Double(num) / 20), value: dragAmount)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged{ dragAmount = $0.translation }
                    .onEnded{ _ in
                        dragAmount = .zero
                        enabled.toggle()
                    }
            )
            
            Spacer()
            
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
            .overlay(
                Circle()
                    .stroke(.red)
                    .opacity(2 - animationAmountImp)
                    .scaleEffect(animationAmountImp)
                    .animation(.easeOut(duration: 1)
                        .repeatForever(autoreverses: false), value: animationAmountImp)
            )
            .onAppear{ animationAmountImp = 2 }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

