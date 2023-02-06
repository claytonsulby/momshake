//
//  Onboarding.swift
//  momshake
//
//  Created by Clayton Sulby on 2/5/23.
//

import SwiftUI

struct Onboarding: View {
    
    @EnvironmentObject var model:Model
    @State var isAnimating:Bool = false
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom) {
                Text("Shake")
                    .font(Font.custom("Secretaryhandmodern", size: 60, relativeTo: .largeTitle))
                    .foregroundColor(.accentColor)
                Text("to begin")
                    .padding(.bottom, 27)
            }
            GeometryReader { proxy in
                ZStack{
                   Image("shakespeare")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)

                    mustache()
                        .rotationEffect(.degrees(-37.5))
                        .offset(x: -(proxy.size.width * 0.109375), y: (proxy.size.height * 0.1))
                        .foregroundColor(Color("LightPurple"))
                }
            }
            .padding()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 320, idealWidth: 320, maxWidth: 320, minHeight: 320, idealHeight: 320, maxHeight: 320)
        }
        .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
            model.firstShake = true
            haptic()
            showOverlay()
        }
    }
    
    func mustache() -> some View {
        Image("shaken-1")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 100, idealWidth: 100, maxWidth: 100, minHeight: 100, idealHeight: 100, maxHeight: 100)
            .padding(50)
            .rotationEffect(.degrees(isAnimating ? -5 : 5))
            .onAppear(perform: {
                withAnimation(.easeInOut(duration: 0.3).repeatForever()) {
                    isAnimating = true
                }
            })
    }
}

extension Onboarding {
    
    func haptic() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func showOverlay() {
        OverlayUtil.shared.showOverlay(reason: .shaken)
    }
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
