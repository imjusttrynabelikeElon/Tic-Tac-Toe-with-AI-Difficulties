//
//  Home Page.swift
//  Tic Tac Toe with AI Difficulties
//
//  Created by Karon Bell on 4/2/23.
//

import SwiftUI
import AVKit
import AVFoundation

struct homeScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @Environment(\.colorScheme) var colorScheme
    var audioPlayer: AVAudioPlayer?
    
    
    func createAudioPlayer() -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.numberOfLoops = -1
                player.play()
                // don't forget to add player.play or your audio will not run.
                return player
            } catch {
                print("Error loading audio file")
            }
        }
        return nil
    }
    
    
    init() {
        audioPlayer = createAudioPlayer()
    }
    
    var body: some View {
        
        
        if isActive {
            GameView()
        } else {
            VStack {
                
                VStack {
                    Image(systemName: "x.square.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    Text(" Tic Tac Toe Game")
                        .font(Font.custom("Baskerville-Bold", size: 17))
                    if colorScheme == .dark {
                        Text("created by Karon Bell")
                            .foregroundColor(.accentColor)
                            .padding(0.3)
                    } else {
                        Text("created by Karon Bell")
                            .foregroundColor(.black)
                            .padding(.bottom, 33)
                            .padding(0.3)
                        
                    }
                    
                    
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.2)) {
                        self.size  = 1.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                    withAnimation {
                        self.isActive = true
                    }
                    
                    
                }
            }
        }
    }
}
