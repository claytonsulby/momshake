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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
