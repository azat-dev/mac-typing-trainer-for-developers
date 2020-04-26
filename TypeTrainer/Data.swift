//
//  Data.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 26.04.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import Foundation

struct KeyCode {
    var value: String
    var representation: String {
        switch value {
        case " ":
            return "˽"
        case "\t":
            return "⟶|"
        case "KC_RGUI":
            return "⌘"
        case "KC_LGUI":
            return "⌘"
        case "KC_LALT":
           return "⌥"
        case "KC_RALT":
            return "⎇"
        case "KC_LCTL":
            return "⌃"
        case "KC_RCTL":
            return "⌃"
        case "KC_LSFT":
            return "⇧"
        case "KC_RSFT":
            return "⇧"
        case "KC_ENT":
            return "↵"
        default:
            return value
        }
    }
    
    init(_ value: String) {
        self.value = value
    }
}

func splitKeysCombination(text t: String) -> [KeyCode] {
    var keys = [KeyCode]()
    var text = t
    
    while true {
        let keyCodeRange = text.range(of: #"KC_[a-zA-Z0-9]+"#, options: .regularExpression)
        if keyCodeRange == nil {
            return keys
        }
        
        let keyCode = String(text[keyCodeRange!])
        keys.append(KeyCode(keyCode))
        text.removeSubrange(keyCodeRange!)
    }
}

struct Token {
    var keys: [Key] = []
    var isTyped = false
    var isWrong = false
    
    var representation: String {
        if keys.count == 1 {
            return keys[0].representation
        }
        
        return "(\(keys.map({ $0.representation }).joined(separator: "+")))"
    }
}

func getTokens(text: String) -> [Token] {
    return [Token]()
//
//    var tokens = [Token]()
//    var textCopy = text;
//
//    while textCopy.count > 0 {
//        var token = Token()
//
//        let keysCombinationRange = textCopy.range(of: #"\((KC_[a-zA-Z0-9]+)(\+(KC_[a-zA-Z0-9]+))*\)"#, options: .regularExpression)
//
//        if let keysCombinationRange = keysCombinationRange, keysCombinationRange.contains(textCopy.startIndex) {
//
//            var keysCombinationText = textCopy[keysCombinationRange]
//            token.keys = splitKeysCombination(text: key)
//            textCopy.removeSubrange(keysCombinationRange)
//
//        } else {
//
//            var character = String(textCopy.removeFirst())
//            token.keys = [Key(character)]
//        }
//
//
//        tokens.append(token)
//    }
//
//    return tokens
}
