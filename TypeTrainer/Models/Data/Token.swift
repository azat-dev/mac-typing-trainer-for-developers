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
        ("a", .init(.a)),
        ("b", .init(.b)),
        ("c", .init(.c)),
        ("d", .init(.d)),
        ("e", .init(.e)),
        ("f", .init(.f)),
        ("g", .init(.g)),
        ("h", .init(.h)),
        ("i", .init(.i)),
        ("j", .init(.j)),
        ("k", .init(.k)),
        ("l", .init(.l)),
        ("m", .init(.m)),
        ("n", .init(.n)),
        ("o", .init(.o)),
        ("p", .init(.p)),
        ("q", .init(.q)),
        ("r", .init(.r)),
        ("s", .init(.s)),
        ("t", .init(.t)),
        ("u", .init(.u)),
        ("v", .init(.v)),
        ("w", .init(.w)),
        ("x", .init(.x)),
        ("y", .init(.y)),
        ("z", .init(.z)),
        
        
        ("A", .init(.a, modifiers: [.leftShift])),
        ("B", .init(.b, modifiers: [.leftShift])),
        ("C", .init(.c, modifiers: [.leftShift])),
        ("D", .init(.d, modifiers: [.leftShift])),
        ("E", .init(.e, modifiers: [.leftShift])),
        ("F", .init(.f, modifiers: [.leftShift])),
        ("G", .init(.g, modifiers: [.leftShift])),
        ("H", .init(.h, modifiers: [.leftShift])),
        ("I", .init(.i, modifiers: [.leftShift])),
        ("J", .init(.j, modifiers: [.leftShift])),
        ("K", .init(.k, modifiers: [.leftShift])),
        ("L", .init(.l, modifiers: [.leftShift])),
        ("M", .init(.m, modifiers: [.leftShift])),
        ("N", .init(.n, modifiers: [.leftShift])),
        ("O", .init(.o, modifiers: [.leftShift])),
        ("P", .init(.p, modifiers: [.leftShift])),
        ("Q", .init(.q, modifiers: [.leftShift])),
        ("R", .init(.r, modifiers: [.leftShift])),
        ("S", .init(.s, modifiers: [.leftShift])),
        ("T", .init(.t, modifiers: [.leftShift])),
        ("U", .init(.u, modifiers: [.leftShift])),
        ("V", .init(.v, modifiers: [.leftShift])),
        ("W", .init(.w, modifiers: [.leftShift])),
        ("X", .init(.x, modifiers: [.leftShift])),
        ("Y", .init(.y, modifiers: [.leftShift])),
        ("Z", .init(.z, modifiers: [.leftShift])),
        
        ("A", .init(.a, modifiers: [.rightShift])),
        ("B", .init(.b, modifiers: [.rightShift])),
        ("C", .init(.c, modifiers: [.rightShift])),
        ("D", .init(.d, modifiers: [.rightShift])),
        ("E", .init(.e, modifiers: [.rightShift])),
        ("F", .init(.f, modifiers: [.rightShift])),
        ("G", .init(.g, modifiers: [.rightShift])),
        ("H", .init(.h, modifiers: [.rightShift])),
        ("I", .init(.i, modifiers: [.rightShift])),
        ("J", .init(.j, modifiers: [.rightShift])),
        ("K", .init(.k, modifiers: [.rightShift])),
        ("L", .init(.l, modifiers: [.rightShift])),
        ("M", .init(.m, modifiers: [.rightShift])),
        ("N", .init(.n, modifiers: [.rightShift])),
        ("O", .init(.o, modifiers: [.rightShift])),
        ("P", .init(.p, modifiers: [.rightShift])),
        ("Q", .init(.q, modifiers: [.rightShift])),
        ("R", .init(.r, modifiers: [.rightShift])),
        ("S", .init(.s, modifiers: [.rightShift])),
        ("T", .init(.t, modifiers: [.rightShift])),
        ("U", .init(.u, modifiers: [.rightShift])),
        ("V", .init(.v, modifiers: [.rightShift])),
        ("W", .init(.w, modifiers: [.rightShift])),
        ("X", .init(.x, modifiers: [.rightShift])),
        ("Y", .init(.y, modifiers: [.rightShift])),
        ("Z", .init(.z, modifiers: [.rightShift])),
        
        ("`", .init(.backtick)),
        ("-", .init(.minus)),
        ("=", .init(.equals)),
        ("[", .init(.leftBracket)),
        ("]", .init(.rightBracket)),
        ("\\", .init(.backslash)),
        (";", .init(.semicolon)),
        
        (":", .init(.semicolon, modifiers: [.leftShift])),
        (":", .init(.semicolon, modifiers: [.rightShift])),
        
        ("\'", .init(.quote)),
        ("\"", .init(.quote, modifiers: [.leftShift])),
        ("\"", .init(.quote, modifiers: [.rightShift])),
        
        (",", .init(.comma)),
        (".", .init(.period)),
        ("/", .init(.slash)),
        
        
        ("0", .init(.alpha0)),
        ("1", .init(.alpha1)),
        ("2", .init(.alpha2)),
        ("3", .init(.alpha3)),
        ("4", .init(.alpha4)),
        ("5", .init(.alpha5)),
        ("6", .init(.alpha6)),
        ("7", .init(.alpha7)),
        ("8", .init(.alpha8)),
        ("9", .init(.alpha9)),
        
        (".", .init(.numpadDecimal)),
        ("*", .init(.numpadMultiply)),
        ("+", .init(.numpadPlus)),
        ("/", .init(.numpadDivide)),
        
        ("\n", .init(.numpadEnter)),
        ("-", .init(.numpadMinus)),
        ("=", .init(.numpadEquals)),
        ("0", .init(.numpad0)),
        ("1", .init(.numpad1)),
        ("2", .init(.numpad2)),
        ("3", .init(.numpad3)),
        ("4", .init(.numpad4)),
        ("5", .init(.numpad5)),
        ("6", .init(.numpad6)),
        ("7", .init(.numpad7)),
        ("8", .init(.numpad8)),
        ("9", .init(.numpad9)),
        
        ("\n", .init(.returnKey)),
        ("\t", .init(.tab)),
        (" ",  .init(.space)),
    ]
}
