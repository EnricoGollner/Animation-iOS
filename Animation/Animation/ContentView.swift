//
//  ContentView.swift
//  Animation
//
//  Created by Enrico Sousa Gollner on 30/11/22.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier{
    var amount: Double
    var anchor: UnitPoint  // Says wich part of the view should cause the rotation
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}


struct ContentView: View{
    
    @State private var animationAmount = 1.0
    
    @State private var animationAmountImp = 1.0
    @State private var animationAmountExp = 0.0
    
    let letters = Array("Hello, SwiftUI")
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    
    @State private var isShowingRed = false
    
    @State private var isShowingBlue = false
    
    var body: some View{
        
        VStack{
            Stepper("Scale amount", value: $animationAmount.animation(.easeIn(duration: 1)), in: 1...10)
            
            Rectangle()
                .fill(LinearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 20, height: 20)
                .scaleEffect(animationAmount)
                .onTapGesture{
                    animationAmount += 1  // No animation
                }
            
            Button("Tap Me"){
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
                    animationAmountExp += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmountExp), axis: (x: 1, y: 1, z: 0))
            .overlay(
                Circle()
                    .stroke(.red)
                    .opacity(2 - animationAmountImp)
                    .scaleEffect(animationAmountImp)
                    .animation(.easeOut(duration: 1)
                        .repeatForever(autoreverses: false),
                               value: animationAmountImp)
            )
            .onAppear{
                animationAmountImp = 2
            }
            
            Spacer()
            
            HStack(spacing: 0){
                ForEach(0..<letters.count){ num in
                    Text(String(letters[num]))
                        .padding(5)
                        .background(enabled ? .blue : .red)
                        .foregroundColor(.white)
                        .font(.title)
                        .offset(dragAmount)
                        .animation(.default
                            .delay(Double(num) / 20),
                                   value: dragAmount)
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
            
            Button(isShowingRed ? "Hide red" : "Show red"){
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
            
            ZStack{
                Rectangle()
                    .fill(.green)
                    .frame(width: 200, height: 200)
                
                if isShowingBlue{
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture{
                withAnimation{
                    isShowingBlue.toggle()
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

