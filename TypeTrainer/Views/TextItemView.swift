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
                return "⏎"
            case .alpha0, .numpad0:
                return "0"
            case .alpha1, .numpad1:
                return "1"
            case .alpha2, .numpad2:
                return "2"
            case .alpha3, .numpad3:
                return "3"
            case .alpha4, .numpad4:
                return "4"
            case .alpha5, .numpad5:
                return "5"
            case .alpha6, .numpad6:
                return "6"
            case .alpha7, .numpad7:
                return "7"
            case .alpha8, .numpad8:
                return "8"
            case .alpha9, .numpad9:
                return "9"
            default:
                return "\(self)"
        }
    }
}

struct TextItemView: View {
    var textItem: TextItem
    
    var representationKeyCombination: String {
        var result = [String]()
        
        //hack
        let keyCombination = textItem.token.rightKeyCombinations[0]
        
        for key in keyCombination.modifiers {
            result.append(key.representation())
        }
        
        result.append(keyCombination.keyCode.representation().uppercased())
        
        return result.joined(separator: "+")
    }
    
    var representation: String {
        if textItem.token.isGroup ||
            textItem.token.character == "\n" ||
            textItem.token.character == " " {
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
            
            } else if textItem.isCompleted {
                
                Text(representation)
                    .font(.title)
                    .fontWeight(.bold)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .padding(3)
            
            } else if textItem.isWrongTyped {
            
                Text(representation)
                    .font(.title)
                    .fontWeight(.bold)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .padding(3)
            
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
                    token: Token("\n")
                )
            )
            
            TextItemView(
                textItem: TextItem(
                    token: Token("(KC_LGUI+KC_A)"),
                    isActive: true
                )
            )
            
            TextItemView(
                textItem: TextItem(
                    token: Token("(KC_LGUI+KC_A)"),
                    isCompleted: true
                )
            )
            
            TextItemView(
                textItem: TextItem(
                    token: Token("(KC_LGUI+KC_A)"),
                    isWrongTyped: true
                )
            )
        }
    }
}
