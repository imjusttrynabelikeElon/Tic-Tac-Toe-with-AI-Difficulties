//
//  Alerts.swift
//  Tic Tac Toe with AI Difficulties
//
//  Created by Karon Bell on 3/28/23.
//


import SwiftUI


struct alertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}


struct AlertContext {
    static let humanWin = alertItem(title: Text("You win!"),
                                    message: Text("You're so smart! You beat the AI."),
                                    buttonTitle: Text("Hell Yeah!"))
    
    static let cpuWin = alertItem(title: Text("You Lost!"),
                                  message: Text("You created a super AI. Try again."),
                                  buttonTitle: Text("Boo Woo!"))
    
    static let draw = alertItem(title: Text("Draw!"),
                                message: Text("Play again."),
                                buttonTitle: Text("Let's run it back!"))
    
    static let gameWon = alertItem(title: Text("Wow You won the game!"),
                                   message: Text("Congratulations! You completed the game."),
                                   buttonTitle: Text("Play again!"))
    
    static let gameLost = alertItem(title: Text("Opps You lost!"),
                                    message: Text("Oops! Better luck next time."),
                                    buttonTitle: Text("Try again!"))
}
