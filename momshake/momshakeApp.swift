//
//  momshakeApp.swift
//  momshake
//
//  Created by Clayton Sulby on 12/4/20.
//

import SwiftUI

@main
struct momshakeApp: App {
    
    @ObservedObject var model = Model()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Secretaryhandmodern", size: UIFont.preferredFont(forTextStyle: .body).pointSize)!]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Secretaryhandmodern", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)!]
    }
    
    var body: some Scene {
        WindowGroup {
            if model.firstShake {
                ContentView()
                    .environmentObject(model)
                    .overlay {
                        MainOverlay()
                    }
                    .accentColor(Color("AccentColor"))
            } else {
                Onboarding()
                    .environmentObject(model)
                    .accentColor(Color("AccentColor"))
            }
        }

    }
}
