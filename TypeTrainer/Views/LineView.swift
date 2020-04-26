//
//  LineView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 26.04.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI

struct LineView: View {
    var tokens: [Token]
    var body: some View {
        HStack(alignment: .center, spacing: 0.0) {
            ForEach(0..<tokens.count) { index in
                TokenView(token: self.tokens[index])
                    .alignmentGuide(/*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Guide@*/.top/*@END_MENU_TOKEN@*/) { dimension in
                        /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Value@*/dimension[.top]/*@END_MENU_TOKEN@*/
                }
            }
        }
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(tokens: [
            Token(keys: [KeyCode("H")]),
            Token(keys: [KeyCode("e")]),
            Token(keys: [KeyCode("l")]),
            Token(keys: [KeyCode("l")]),
            Token(keys: [KeyCode("o")]),
            Token(keys: [KeyCode(" ")]),
            Token(keys: [KeyCode("KC_LGUI"), KeyCode("KC_A")]),
        ])
    }
}
