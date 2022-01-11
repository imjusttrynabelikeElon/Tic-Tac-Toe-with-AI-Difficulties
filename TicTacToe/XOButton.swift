//
//  XOButton.swift
//  TicTacToe
//
//  Created by Federico on 11/01/2022.
//

import SwiftUI

struct XOButton: View {
    @Binding var letter: String
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 120, height: 120)
                .foregroundColor(.blue)
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
            Text(letter)
                .font(.system(size: 50))
                .bold()
         
            
            
        }
    }
}

struct XOButton_Previews: PreviewProvider {
    static var previews: some View {
        XOButton(letter: .constant("X"))
    }
}
