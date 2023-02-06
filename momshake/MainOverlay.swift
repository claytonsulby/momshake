//
//  MainOverlay.swift
//  JSFun
//
//  Created by Clayton Sulby on 4/26/22.
//

import SwiftUI
import SwiftUIX

struct MainOverlay : View {
    
    @ObservedObject var util = OverlayUtil.shared
    
    var body : some View {
        
        
        content(util.reason)
            .background(
                card()
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 5)
            )
            .frame(minWidth: 100, idealWidth: 277.5, maxWidth: 277.5)
            .opacity(util.overlayIsShowing ? 1 : 0)
            .transition(.opacity.combined(with: .scale))
        
    }
    
    func content(_ reason: OverlayReason) -> some View {
        Group {
            switch reason {
            case .shaken:
                shaken()
            default:
                EmptyView()
            }
        }
    }
    
    func card() -> some View {
        BlurEffectView(style: .regular)
    }
    
    @State var isAnimating:Bool = false
    
    func shaken() -> some View {
        VStack{
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
                .foregroundColor(Color("LightPurple"))
            
            
            Text("Shaking")
                .font(.secretaryHand)
        }.padding(.bottom)
    }
}

struct MainOverlay_Previews: PreviewProvider {
    static var previews: some View {
        MainOverlay()
    }
}

//
//  OverlayUtil.swift
//  JSFun
//
//  Created by Clayton Sulby on 4/26/22.
//

import Foundation
import SwiftUI

enum OverlayReason {
    case none
    case shaken
}

class OverlayUtil : ObservableObject {
    
    static let shared = OverlayUtil()
    private init() {}

    @Published private var _reason:OverlayReason = .none
    @Published private var _overlayIsShowing:Bool = false

    func showOverlay(reason: OverlayReason) {
        self._reason = reason
        withAnimation {
            _overlayIsShowing = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1800)) {
            withAnimation {
                self._overlayIsShowing = false
            }
            
        }
    }

    var overlayIsShowing:Bool {
        withAnimation {
            self._overlayIsShowing
        }
    }

    var reason:OverlayReason {
        withAnimation {
            self._reason
        }
    }
    
}
