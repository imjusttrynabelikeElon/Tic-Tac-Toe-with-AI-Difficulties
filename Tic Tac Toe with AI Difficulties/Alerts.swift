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
    static  let humanWin  = alertItem(title: Text("You win!"),
                                      message: Text("Your so fucking smart! you beat your own AI"),
                                      buttonTitle: Text("Hell Yeah!"))
    
    static   let CpuWin   = alertItem(title: Text("You Lost!"),
                                      message: Text("You created a super AI. Try Again"),
                                      buttonTitle: Text("Boo Woo!"))
    
    static  let Draw    = alertItem(title: Text("Draw!"),
                                    message: Text("Play Again"),
                                    buttonTitle: Text("Lets Do This Shit!"))
}
