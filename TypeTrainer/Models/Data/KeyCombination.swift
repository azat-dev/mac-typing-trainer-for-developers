//
//  KeyCombination.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 29.04.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

struct KeyCombination: Equatable {
    var keyCode: KeyCode
    var modifiers: [KeyCode] = []
    
    init(_ keyCode: KeyCode, modifiers: [KeyCode] = []) {
        self.keyCode = keyCode
        self.modifiers = modifiers
    }
    
    init(keyCode: KeyCode, modifiers: [KeyCode] = []) {
        self.init(keyCode, modifiers: modifiers)
    }
    
    init(_ keyCode: KeyCode) {
        self.keyCode = keyCode
    }
}
