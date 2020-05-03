//
//  TextItemView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 03.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI

extension KeyCode {
    func representation() -> String {
        switch self {
            case .space:
                return "˽"
            case .tab:
                    return "⟶|"
            case .command:
                    return "⌘"
            case .leftAlt:
                   return "⌥"
            case .rightAlt:
                    return "⎇"
            case .leftControl, .rightControl:
                    return "⌃"
            case .leftShift, .rightShift:
                    return "⇧"
            case .returnKey, .numpadEnter:
                return "↵"
            default:
                return "\(self)"
        }
    }
}

struct TextItemView: View {
    var textItem: TextItem
    
    var representationKeyCombination: String {
        var result = [String]()
        
        let keyCombination = textItem.token.keyCombinations[0]
        
        for key in keyCombination.modifiers {
            result.append(key.representation())
        }
        
        result.append(keyCombination.keyCode.representation().uppercased())
        
        return result.joined(separator: "+")
    }
    
    var representation: String {
        if textItem.token.isGroup {
            return representationKeyCombination
        }
        
        return String(textItem.token.character)
    }
    
    var body: some View {
        VStack {
            Text(representation)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(1.0)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .padding(/*@START_MENU_TOKEN@*/.vertical, 5.0/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TextItemView_Previews: PreviewProvider {
    static var previews: some View {
        TextItemView(
            textItem: TextItem(
                token: Token("(KC_LGUI+KC_A)")
            )
        )
    }
}
