//
//  Token.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 03.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import Foundation

struct Token: Equatable {
    var text: String
    
    init(_ character: Character) {
        self.text = String(character)
    }

    init(_ text: String) {
        self.text = text
    }
    
    var isGroup: Bool {
        text.count > 0 && text.hasPrefix("(KC_") && text.hasSuffix(")")
    }
    
    var rightKeyCombinations: [KeyCombination] {
        if isGroup {
            return [try! parseKeyCombinationGroupText(text: text)]
        }
    
        let character = text.first!
        return Token.charactersMap.filter{ $0.0 == character }
            .map { (value) -> KeyCombination in value.1 }
    }
    
    var character: Character {
        let keyCombinations = self.rightKeyCombinations
        
        for (_, _) in Token.charactersMap {
            let foundItem = Token.charactersMap.first {
                keyCombinations.contains($0.1)
            }
            
            if foundItem != nil {
                return foundItem!.0
            }
        }
        
        return "_"
    }
    
    static let charactersMap: [(Character, KeyCombination)] = [
        ("a", KeyCombination(.a)),
        ("b", KeyCombination(.b)),
        ("c", KeyCombination(.c)),
        ("d", KeyCombination(.d)),
        ("e", KeyCombination(.e)),
        ("f", KeyCombination(.f)),
        ("g", KeyCombination(.g)),
        ("h", KeyCombination(.h)),
        ("i", KeyCombination(.i)),
        ("j", KeyCombination(.j)),
        ("k", KeyCombination(.k)),
        ("l", KeyCombination(.l)),
        ("m", KeyCombination(.m)),
        ("n", KeyCombination(.n)),
        ("o", KeyCombination(.o)),
        ("p", KeyCombination(.p)),
        ("q", KeyCombination(.q)),
        ("r", KeyCombination(.r)),
        ("s", KeyCombination(.s)),
        ("t", KeyCombination(.t)),
        ("u", KeyCombination(.u)),
        ("v", KeyCombination(.v)),
        ("w", KeyCombination(.w)),
        ("x", KeyCombination(.x)),
        ("y", KeyCombination(.y)),
        ("z", KeyCombination(.z)),
        
        
        ("A", KeyCombination(.a, modifiers: [.leftShift])),
        ("B", KeyCombination(.b, modifiers: [.leftShift])),
        ("C", KeyCombination(.c, modifiers: [.leftShift])),
        ("D", KeyCombination(.d, modifiers: [.leftShift])),
        ("E", KeyCombination(.e, modifiers: [.leftShift])),
        ("F", KeyCombination(.f, modifiers: [.leftShift])),
        ("G", KeyCombination(.g, modifiers: [.leftShift])),
        ("H", KeyCombination(.h, modifiers: [.leftShift])),
        ("I", KeyCombination(.i, modifiers: [.leftShift])),
        ("J", KeyCombination(.j, modifiers: [.leftShift])),
        ("K", KeyCombination(.k, modifiers: [.leftShift])),
        ("L", KeyCombination(.l, modifiers: [.leftShift])),
        ("M", KeyCombination(.m, modifiers: [.leftShift])),
        ("N", KeyCombination(.n, modifiers: [.leftShift])),
        ("O", KeyCombination(.o, modifiers: [.leftShift])),
        ("P", KeyCombination(.p, modifiers: [.leftShift])),
        ("Q", KeyCombination(.q, modifiers: [.leftShift])),
        ("R", KeyCombination(.r, modifiers: [.leftShift])),
        ("S", KeyCombination(.s, modifiers: [.leftShift])),
        ("T", KeyCombination(.t, modifiers: [.leftShift])),
        ("U", KeyCombination(.u, modifiers: [.leftShift])),
        ("V", KeyCombination(.v, modifiers: [.leftShift])),
        ("W", KeyCombination(.w, modifiers: [.leftShift])),
        ("X", KeyCombination(.x, modifiers: [.leftShift])),
        ("Y", KeyCombination(.y, modifiers: [.leftShift])),
        ("Z", KeyCombination(.z, modifiers: [.leftShift])),
        
        ("A", KeyCombination(.a, modifiers: [.rightShift])),
        ("B", KeyCombination(.b, modifiers: [.rightShift])),
        ("C", KeyCombination(.c, modifiers: [.rightShift])),
        ("D", KeyCombination(.d, modifiers: [.rightShift])),
        ("E", KeyCombination(.e, modifiers: [.rightShift])),
        ("F", KeyCombination(.f, modifiers: [.rightShift])),
        ("G", KeyCombination(.g, modifiers: [.rightShift])),
        ("H", KeyCombination(.h, modifiers: [.rightShift])),
        ("I", KeyCombination(.i, modifiers: [.rightShift])),
        ("J", KeyCombination(.j, modifiers: [.rightShift])),
        ("K", KeyCombination(.k, modifiers: [.rightShift])),
        ("L", KeyCombination(.l, modifiers: [.rightShift])),
        ("M", KeyCombination(.m, modifiers: [.rightShift])),
        ("N", KeyCombination(.n, modifiers: [.rightShift])),
        ("O", KeyCombination(.o, modifiers: [.rightShift])),
        ("P", KeyCombination(.p, modifiers: [.rightShift])),
        ("Q", KeyCombination(.q, modifiers: [.rightShift])),
        ("R", KeyCombination(.r, modifiers: [.rightShift])),
        ("S", KeyCombination(.s, modifiers: [.rightShift])),
        ("T", KeyCombination(.t, modifiers: [.rightShift])),
        ("U", KeyCombination(.u, modifiers: [.rightShift])),
        ("V", KeyCombination(.v, modifiers: [.rightShift])),
        ("W", KeyCombination(.w, modifiers: [.rightShift])),
        ("X", KeyCombination(.x, modifiers: [.rightShift])),
        ("Y", KeyCombination(.y, modifiers: [.rightShift])),
        ("Z", KeyCombination(.z, modifiers: [.rightShift])),
        
        ("`", KeyCombination(.backtick)),
        ("-", KeyCombination(.minus)),
        ("=", KeyCombination(.equals)),
        ("[", KeyCombination(.leftBracket)),
        ("]", KeyCombination(.rightBracket)),
        ("\\", KeyCombination(.backslash)),
        (";", KeyCombination(.semicolon)),
        
        (":", KeyCombination(.semicolon, modifiers: [.leftShift])),
        (":", KeyCombination(.semicolon, modifiers: [.rightShift])),
        
        ("\'", KeyCombination(.quote)),
        ("\"", KeyCombination(.quote, modifiers: [.leftShift])),
        ("\"", KeyCombination(.quote, modifiers: [.rightShift])),
        
        (",", KeyCombination(.comma)),
        (".", KeyCombination(.period)),
        ("/", KeyCombination(.slash)),
        
        (".", KeyCombination(.numpadDecimal)),
        ("*", KeyCombination(.numpadMultiply)),
        ("+", KeyCombination(.numpadPlus)),
        ("/", KeyCombination(.numpadDivide)),
        
        ("\n", KeyCombination(.numpadEnter)),
        ("-", KeyCombination(.numpadMinus)),
        ("=", KeyCombination(.numpadEquals)),
        ("0", KeyCombination(.numpad0)),
        ("1", KeyCombination(.numpad1)),
        ("2", KeyCombination(.numpad2)),
        ("3", KeyCombination(.numpad3)),
        ("4", KeyCombination(.numpad4)),
        ("5", KeyCombination(.numpad5)),
        ("6", KeyCombination(.numpad6)),
        ("7", KeyCombination(.numpad7)),
        ("8", KeyCombination(.numpad8)),
        ("9", KeyCombination(.numpad9)),
        
        ("\n", KeyCombination(.returnKey)),
        ("\t", KeyCombination(.tab)),
        (" ", KeyCombination(.space)),
    ]
}
