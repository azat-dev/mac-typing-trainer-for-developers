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
                return " "
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
            if textItem.isActive {
                Text(representation)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 117.0, green: 117.0, blue: 117.0, opacity: 1.0))
                    .padding(3)
                    .border(Color.blue, width: 3)
            } else {
                Text(representation)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 117.0, green: 117.0, blue: 117.0, opacity: 1.0))
                        .padding(3)
            }
        }
    }
}

struct TextItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextItemView(
                textItem: TextItem(
                    token: Token("(KC_LGUI+KC_A)")
                )
            )
            TextItemView(
                textItem: TextItem(
                    token: Token("(KC_LGUI+KC_A)"),
                    isActive: true
                )
            )
        }
    }
}
