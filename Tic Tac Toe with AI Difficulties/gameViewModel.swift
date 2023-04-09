//
//  gameViewModel.swift
//  Tic Tac Toe with AI Difficulties
//
//  Created by Karon Bell on 4/9/23.
//


import SwiftUI




final class GameViewModel: ObservableObject {
    
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @Published var moves: [GameView.Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var AlertItem: alertItem?
    
    @Published var humanScore = 0
    @Published var cpuScore = 0
    
    @Published var score = 0 {
        didSet {
            if score > 0 {
                humanScore += 1
            } else if score < 0 {
                cpuScore += 1
            }
        }
    }
    
    
    
    
    // this hi hifix the amount
    // this is working with my Alerts.swift file to use that Alert code on this file.
    
    
    
    func processingPlayerMove(for i: Int) {
        if isSquareOccupied(in: moves, forIndex: i) { return }
        moves[i] = GameView.Move(player: .human, boardIndex: i)
        
        // check for win or draw
        
        if checkWinCondition(for: .human, in: moves) {
            humanScore += 1
            AlertItem = AlertContext.humanWin
            
            return
        }
        
        if checkForDraw(in: moves) {
            AlertItem = AlertContext.Draw
            return
        }
        isGameBoardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let cpuPosition = determineCpuMovePosition(in: self.moves)
            self.moves[cpuPosition] = GameView.Move(player: .computer, boardIndex: cpuPosition)
            self.isGameBoardDisabled = false
            
            if checkWinCondition(for: .computer, in: self.moves) {
                self.cpuScore +=  1
                self.AlertItem = AlertContext.CpuWin
                return
            }
            if checkForDraw(in: self.moves) {
                self.AlertItem = AlertContext.Draw
                return
            }
        }
        
        
        func isSquareOccupied(in moves: [GameView.Move?], forIndex index: Int) -> Bool {
            return moves.contains(where: {$0?.boardIndex == index})
        }
        
        // if AI can win.. win
        // if AI can't win then block
        // if AI can't block then take middle square
        // if AI can't take middle square, take random avilable square
        
        
        func determineCpuMovePosition(in moves: [GameView.Move?]) -> Int {
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
        
        
        func determineScore(for player: GameView.Player, in moves: [GameView.Move?]) -> Int {
            if checkWinCondition(for: .human, in: moves) {
                
                return 1
            } else if checkWinCondition(for: .computer, in: moves) {
                return -1
            } else {
                return 0
            }
        }
        
        func checkWinCondition(for player: GameView.Player, in moves: [GameView.Move?]) -> Bool {
            let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7 ,8], [ 0, 3, 6], [1, 4 ,7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
            
            let playerMoves = moves.compactMap { $0 }.filter { $0.player == player}
            let playerPositions = Set(playerMoves.map { $0.boardIndex })
            
            for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
            
            
            return false
        }
        
        func checkForDraw(in moves: [GameView.Move?]) -> Bool {
            return moves.compactMap { $0 }.count == 9
        }
        
        
        
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
    
    
    
    
    
}
//
