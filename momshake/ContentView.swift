//
//  ContentView.swift
//  momshake
//
//  Created by Clayton Sulby on 12/4/20.
//

import SwiftUI
import SwiftUIX
import MessageUI

struct ContentView: View {
    
    private let messageComposeDelegate = MessageComposerDelegate()
    
    @EnvironmentObject var model:Model

    @State var firstSelection:Int = 0
    @State var secondSelection:Int = 0
    @State var thirdSelection:Int = 0
    
    @State var showComposeSidebar:Bool = false
    
    var insult:String {
        return "\(self.model.firstSelections[firstSelection]) \(self.model.secondSelections[secondSelection]) \(self.model.thirdSelections[thirdSelection])"
    }
    
    var message:String {
        return "\(self.model.context.randomElement()!) \(self.insult)!"
    }
    
    var body: some View {
        
        NavigationView {
            ZStack{
                content()
            }
            .navigationTitle("Thou art a...")
            .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
                
                randomize()
                
            }
        }
    }
}

extension ContentView {
    
    func content() -> some View {
        ZStack{
            prompts()
            VStack{
                Spacer()
                toolbar()
            }
        }
    }
    
}

// Supplementary Views
extension ContentView {
    
    func toolbar() -> some View {
        VStack(spacing: 10.0){
            
            Divider()
            
            HStack(alignment: .bottom, spacing: 20) {
                composeSidebar()
                composeField()
            }
            .padding(.horizontal)

            

        }
        .background (

            BlurEffectView(style: .systemUltraThinMaterial)
                .edgesIgnoringSafeArea([.bottom, .horizontal])
        )
    }
    
    
    @ViewBuilder
    func composeSidebar() -> some View {
        
        Group{
            if (showComposeSidebar) {
                Button(action: {
                    randomize()
                }) {
                    Image(systemName: "shuffle")
                }
                .transition(.move(edge: .leading).combined(with: .opacity))
            } else {
                Button(action: {
                    withAnimation(.easeInOut) {
                        showComposeSidebar.toggle()
                    }
                }) {
                    Image(systemName: "chevron.forward.square.fill")
                        .imageScale(.large)
                        .foregroundColor(.secondary)
                    
                }
                .transition(.asymmetric(insertion: .opacity.combined(with: .scale), removal: .move(edge: .trailing).combined(with: .opacity)))
            }
        }.padding(.bottom, 5)

    }
    
    func composeField() -> some View {
        
        HStack(alignment: .bottom) {
            Text("...\(self.insult)!")
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(showComposeSidebar ? 1 : nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.presentMessageCompose()
                showComposeSidebar = false
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
        }.padding(.leading, 10)
        .padding(.trailing, 7.5)
        .padding([.top, .bottom], 7.25)
        .background(RoundedRectangle(cornerRadius: 15.0).stroke(lineWidth: 1.0).foregroundColor(.secondary))
        .onTapGesture {
            self.presentMessageCompose()
            showComposeSidebar = false
        }
        
    }
    
    func prompt(insult: Insult) -> some View {
        HStack{
            VStack(alignment: .leading){
                Text("\(insult.insult)")
                    .font(.title)
//                  .font(Font.custom("Zainer-Gotico-Antiqua96G", size: 25.0, relativeTo: .title))
                    .padding(.bottom, 2)
                Text("\(insult.source_line)")
                    .font(.caption).italic()
                Text("\"\(insult.source_quote)\"")
                    .font(.caption)
            }
            Spacer()
        }
    }
    
    func prompts() -> some View {
        
        List {
            prompt(insult: self.model.firstInsults[firstSelection])
            prompt(insult: self.model.secondInsults[secondSelection])
            prompt(insult: self.model.thirdInsults[thirdSelection])
        }.listStyle(.plain)
        
    }
}

//Actions
extension ContentView {
    
    
    func randomize() {
        
        firstSelection = (0..<self.model.firstSelections.count).randomElement()!
        secondSelection = (0..<self.model.secondSelections.count).randomElement()!
        thirdSelection = (0..<self.model.thirdSelections.count).randomElement()!
        
    }
    
    private class MessageComposerDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
        }
    }
    
    /// Present an message compose view controller modally in UIKit environment
    private func presentMessageCompose() {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate
        composeVC.body = self.message
        
        vc?.present(composeVC, animated: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Model())
    }
}
