//
//  ContentView.swift
//  Tic Tac Toe with AI Difficulties
//
//  Created by Karon Bell on 3/28/23.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .trailing) {
                    HStack {
                        Text("Player: \(viewModel.humanScore)")
                        Spacer()
                        Text("CPU: \(viewModel.cpuScore)")
                    }
                    .font(.headline)
                    
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 69)
                    .padding(.vertical, 13)
                    .padding(.top, 33)
                    .padding(.bottom, 15)
                    
                    Spacer()
                    Text("Created by Karon Bell")
                        .font(.system(size: 23))
                        .padding(13)
                        .foregroundColor(.secondary)
                    LazyVGrid(columns: viewModel.columns, spacing: 11) {
                        ForEach(0..<9) { i in
                            ZStack {
                                Circle()
                                    .foregroundColor(.red).opacity(0.5)
                                    .frame(width: geometry.size.width/3.5, height: geometry.size.width/3.5)
                                
                                Image(systemName: viewModel.moves[i]?.indictor ?? "")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                            }
                            .onTapGesture {
                                viewModel.processingPlayerMove(for: i)
                            }
                            // thisd is the amount
                        }
                    }
                    Spacer()
                }
                .padding()
                .disabled(viewModel.isGameBoardDisabled)
                .navigationTitle("TicTacToe with CPU")
                
                .alert(item: $viewModel.AlertItem, content: { AlertItem in
                    Alert(title: AlertItem.title, message: AlertItem.message, dismissButton: .default(AlertItem.buttonTitle, action: {
                        
                        
                        viewModel.resetGame()
                        // make sure all your funcs are in the right spot
                    }))
                })
                
            }
            
        }
    }
    
    
    
    enum Player {
        case human, computer
    }
    
    struct Move {
        let player: Player
        let boardIndex: Int
        
        var indictor: String {
            return player == .human ? "xmark" : "circle"
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            GameView()
        }
    }
}


