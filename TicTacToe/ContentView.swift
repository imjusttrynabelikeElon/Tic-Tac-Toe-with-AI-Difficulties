//
//  ContentView.swift
//  TicTacToe
//
//  Created by Federico on 11/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["","","","","","","","",""]
    @State private var endGameText = "TicTacToe"
    
    
    var body: some View {
        VStack {
            
            Text(endGameText)
            Spacer()
            HStack {
                ForEach(0..<3, id: \.self) { i in
                    XOButton(letter: $moves[i])
                        .onTapGesture {
                            print("Tap: \(i)")
                            playerTap(index: i)
                        }
                }
            }
            HStack {
                ForEach(3..<6, id: \.self) { i in
                    XOButton(letter: $moves[i])
                        .onTapGesture {
                            print("Tap: \(i)")
                            playerTap(index: i)
                        }
                }
            }
            HStack {
                ForEach(6..<9, id: \.self) { i in
                    XOButton(letter: $moves[i])
                        .onTapGesture {
                            print("Tap: \(i)")
                            playerTap(index: i)
                        }
                }
            }
            Spacer()
            Button("Reset") {
                
            }
        }
    }
    
    func playerTap(index: Int) {
        if moves[index] == "" {
            moves[index] = "X"
            botMove()
        }
        
        if checkWinner(list: moves, letter: "X") {
            endGameText = "X has won!"
        } else if checkWinner(list: moves, letter: "O") {
            endGameText = "O has won!"
        }
        
    }
    
    func botMove() {
        var availableMoves: [Int] = []
        var movesLeft = 0
        
        // Check the available moves left
        for move in moves {
            if move == "" {
                availableMoves.append(movesLeft)
            }
            movesLeft += 1
        }
        
        // Make sure there are moves left before bot moves
        if availableMoves.count != 0 {
            moves[availableMoves.randomElement()!] = "O"
        }
        
        // Logging
        print(availableMoves)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
