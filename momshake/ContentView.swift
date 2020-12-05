//
//  ContentView.swift
//  momshake
//
//  Created by Clayton Sulby on 12/4/20.
//

import SwiftUI
import MessageUI

struct ContentView: View {
    
    private let messageComposeDelegate = MessageComposerDelegate()
    
    @EnvironmentObject var model:Model
    
    @State var firstSelection:Int = 0
    @State var secondSelection:Int = 0
    @State var thirdSelection:Int = 0
    
    var insult:String {
        return "\(self.model.firstSelections[firstSelection]) \(self.model.secondSelections[secondSelection]) \(self.model.thirdSelections[thirdSelection])"
    }
    
    var message:String {
        return "\(self.model.context.randomElement()!) \(self.insult)!"
    }
    
    var body: some View {
        GeometryReader { outerGeometry in
            
            VStack {
                
                //MARK: section 1
                Group {
                    HStack{
                        Text("Thou art a...")
                            .padding([.leading, .top])
                            .font(.largeTitle)
                        //.font(Font.custom("william-shakespeare-wf", size: 25.0))
                        Spacer()
                    }
                    
                    Group {
                        HStack{
                            VStack(alignment: .leading){
                                
                                Text("\(self.model.firstSelections[firstSelection])...")
                                    .foregroundColor(.yellow)
                                    .font(.title)
                                    .padding(.bottom, 2)
                                Text("\(self.model.firstInsults[firstSelection].source_line)")
                                    .font(.caption).italic()
                                Text("\"\(self.model.firstInsults[firstSelection].source_quote)\"")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                        HStack{
                            VStack(alignment: .leading){
                                
                                Text("...\(self.model.secondSelections[secondSelection])...")
                                    .foregroundColor(.green)
                                    .font(.title)
                                    .padding(.bottom, 2)
                                Text("\(self.model.secondInsults[secondSelection].source_line)")
                                    .font(.caption).italic()
                                Text("\"\(self.model.secondInsults[secondSelection].source_quote)\"")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                        HStack{
                            VStack(alignment: .leading){
                                Text("...\(self.model.thirdSelections[thirdSelection])!")
                                    .foregroundColor(.purple)
                                    .font(.title)
                                    .padding(.bottom, 2)
                                Text("\(self.model.thirdInsults[thirdSelection].source_line)")
                                    .font(.caption).italic()
                                Text("\"\(self.model.thirdInsults[thirdSelection].source_quote)\"")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                        
                    }.padding()
                }
                
                
                Spacer()
                
                //MARK: section 2
                Group {
                    GeometryReader { geometry in
                        ZStack{
                            HStack(alignment: .bottom, spacing: 0.0){
                                Rectangle()
                                    .foregroundColor(.yellow)
                                    .frame(width: geometry.size.width/3, height: 21)
                                    .clipped()
                                Rectangle()
                                    .foregroundColor(.green)
                                    .frame(width: geometry.size.width/3, height: 21)
                                    .clipped()
                                Rectangle()
                                    .foregroundColor(.purple)
                                    .frame(width: geometry.size.width/3, height: 21)
                                    .clipped()
                            }.opacity(0.5)
                            
                            HStack(spacing: 0.0) {
                                Picker(selection: self.$firstSelection, label: Text(""), content: {
                                    ForEach(0..<self.model.firstSelections.count){ index in
                                        Text(self.model.firstSelections[index]).tag(index)
                                    }
                                }).scaleEffect(0.7)
                                .frame(width: geometry.size.width/3)
                                .clipped()
                                Picker(selection: self.$secondSelection, label: Text(""), content: {
                                    ForEach(0..<self.model.secondSelections.count){ index in
                                        Text(self.model.secondSelections[index]).tag(index)
                                    }
                                }).scaleEffect(0.7)
                                .frame(width: geometry.size.width/3)
                                .clipped()
                                Picker(selection: self.$thirdSelection, label: Text(""), content: {
                                    ForEach(0..<self.model.thirdSelections.count){ index in
                                        Text(self.model.thirdSelections[index]).tag(index)
                                    }
                                }).scaleEffect(0.7)
                                .frame(width: geometry.size.width/3)
                                .clipped()
                            }
                        }
                    }
                }
                
                //MARK: section 3
                Group{
                    
                    Button(action: {
                        firstSelection = (0..<self.model.firstSelections.count).randomElement()!
                        secondSelection = (0..<self.model.secondSelections.count).randomElement()!
                        thirdSelection = (0..<self.model.thirdSelections.count).randomElement()!
                        //self.model.fontHelp()
                    }) {
                        Text("Randomize!")
                    }
                    
                    HStack(alignment: .bottom) {
                        Text("...\(self.insult)!")
                            .foregroundColor(.primary)
                        Button(action: {
                            self.presentMessageCompose()
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(.secondary)
                                .scaleEffect(1.5)
                        }
                    }.padding(.leading, 10)
                    .padding(.trailing, 7.5)
                    .padding([.top, .bottom], 7.25)
                    .background(RoundedRectangle(cornerRadius: 15.0).stroke(lineWidth: 1.0).foregroundColor(.secondary))
                    
                }
            }
        }
    }
}

extension ContentView {
    
    private class MessageComposerDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            // Customize here
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
