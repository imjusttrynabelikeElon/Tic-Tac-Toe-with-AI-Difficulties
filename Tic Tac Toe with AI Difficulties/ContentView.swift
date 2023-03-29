//
//  ContentView.swift
//  Tic Tac Toe with AI Difficulties
//
//  Created by Karon Bell on 3/28/23.
//

import SwiftUI

struct ContentView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameBoardDisabled = false
   @State private var AlertItem: alertItem?
    // this is working with my Alerts.swift file to use that Alert code on this file.
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .trailing) {
                    
                    Spacer()
                    Text("Created by Karon Bell")
                             .font(.system(size: 23))
                             .padding(13)
                             .foregroundColor(.secondary)
                    LazyVGrid(columns: columns, spacing: 11) {
                        ForEach(0..<9) { i in
                            ZStack {
                                Circle()
                                    .foregroundColor(.red).opacity(0.5)
                                    .frame(width: geometry.size.width/3.5, height: geometry.size.width/3.5)
                                
                                Image(systemName: moves[i]?.indictor ?? "")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                            }
                            .onTapGesture {
                                if isSquareOccupied(in: moves, forIndex: i) { return }
                                moves[i] = Move(player: .human, boardIndex: i)
                                
                                // check for win or draw
                                
                                if checkWinCondition(for: .human, in: moves) {
                                    AlertItem = AlertContext.humanWin
                                    return
                                }
                                
                                if checkForDraw(in: moves) {
                                    AlertItem = AlertContext.Draw
                                    return
                                }
                                isGameBoardDisabled = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    let cpuPosition = determineCpuMovePosition(in: moves)
                                    moves[cpuPosition] = Move(player: .computer, boardIndex: cpuPosition)
                                    isGameBoardDisabled = false
                                    
                                    if checkWinCondition(for: .computer, in: moves) {
                                        AlertItem = AlertContext.CpuWin
                                        return
                                    }
                                    if checkForDraw(in: moves) {
                                        AlertItem = AlertContext.Draw
                                        return
                                    }
                                }
                            }
                       
                        }
                    }
                    Spacer()
                }
                .padding()
                .disabled(isGameBoardDisabled)
                .navigationTitle("TicTacToe with CPU AI")
                .alert(item: $AlertItem, content: { AlertItem in
                    Alert(title: AlertItem.title, message: AlertItem.message, dismissButton: .default(AlertItem.buttonTitle, action: {
                        resetGame()
                    }))
                })
                
            }
          
        }
       
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    // if AI can win.. win
    // if AI can't win then block
    // if AI can't block then take middle square
    // if AI can't take middle square, take random avilable square

    
    func determineCpuMovePosition(in moves: [Move?]) -> Int {
        // if AI can win.. win
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7 ,8], [ 0, 3, 6], [1, 4 ,7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let cpuMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let cpuPositions = Set(cpuMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(cpuPositions)
            
            if winPositions.count == 1 {
                let index = winPositions.first!
                
                if !isSquareOccupied(in: moves, forIndex: index) {
                    return index
                }
            }
        }
        
        // if AI can't win then block
        
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human}
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let index = winPositions.first!
                
                if !isSquareOccupied(in: moves, forIndex: index) {
                    return index
                }
            }
        }
        
        // if AI can't block then take middle square
        
        if !isSquareOccupied(in: moves, forIndex: 4) {
            return 4
        }
        
        // if AI can't take middle square, take random avilable square
        
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }


    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7 ,8], [ 0, 3, 6], [1, 4 ,7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player}
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
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
        ContentView()
    }
}
