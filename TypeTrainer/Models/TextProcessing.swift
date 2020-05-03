import Foundation
import Sauce



enum TextProcessingError: Error {
    case wrongKeyCode(String)
    case wrongKeyCodeCombination(String)
}

func parseKeyCodeText(text: String) throws -> KeyCode {
    let keyCodeMap: [String:KeyCode] = [
        "KC_A": .a,
        "KC_B": .b,
        "KC_C": .c,
        "KC_D": .d,
        "KC_E": .e,
        "KC_F": .f,
        "KC_G": .g,
        "KC_H": .h,
        "KC_I": .i,
        "KC_J": .j,
        "KC_K": .k,
        "KC_L": .l,
        "KC_M": .m,
        "KC_N": .n,
        "KC_O": .o,
        "KC_P": .p,
        "KC_Q": .q,
        "KC_R": .r,
        "KC_S": .s,
        "KC_T": .t,
        "KC_U": .u,
        "KC_V": .v,
        "KC_W": .w,
        "KC_X": .x,
        "KC_Y": .y,
        "KC_Z": .z,
        
        "KC_GRV": .backtick,
        "KC_MINS": .minus,
        "KC_EQL": .equals,
        "KC_LBRC": .leftBracket,
        "KC_RBRC": .rightBracket,
        "KC_BSLS": .backslash,
        "KC_SCLN": .semicolon,
        "KC_QUOT": .quote,
        "KC_COMM": .comma,
        "KC_DOT": .period,
        "KC_SLSH": .slash ,
        
        "KC_PDOT": .numpadDecimal,
        "KC_PAST": .numpadMultiply,
        "KC_PPLS": .numpadPlus  ,
        "KC_NLCK": .numpadClear ,
        "KC_PSLS": .numpadDivide,
        "KC_PENT": .numpadEnter ,
        "KC_PMNS": .numpadMinus ,
        "KC_PEQL": .numpadEquals,
        "KC_P0": .numpad0,
        "KC_P1": .numpad1,
        "KC_P2": .numpad2,
        "KC_P3": .numpad3,
        "KC_P4": .numpad4,
        "KC_P5": .numpad5,
        "KC_P6": .numpad6,
        "KC_P7": .numpad7,
        "KC_P8": .numpad8,
        "KC_P9": .numpad9,
        
        "KC_ENT": .returnKey,
        "KC_LTAB": .tab,
        "KC_RTAB": .tab,
        "KC_SPC": .space,
        "KC_BSPC": .backspace,
        "KC_ESC": .escape,
        "KC_LSFT": .leftShift,
        "KC_RSFT": .rightShift,
        "KC_CAPS": .capsLock,
        //        "KC_": .function    ,
        "KC_LCTL": .leftControl ,
        "KC_RCTL": .rightControl,
        "KC_LALT": .leftAlt ,
        "KC_RALT": .rightAlt,
        "KC_LGUI": .command,
        "KC_RGUI": .command,
        "KC_DEL": .delete,
        "KC_HOME": .home,
        "KC_END": .end,
        "KC_PGUP": .pageUp,
        "KC_PGDN": .pageDown,
        "KC_LEFT": .leftArrow,
        "KC_RIGHT": .rightArrow,
        "KC_DOWN": .downArrow,
        "KC_UP": .upArrow,
        
        "KC_F1": .f1,
        "KC_F2": .f2,
        "KC_F3": .f3,
        "KC_F4": .f4,
        "KC_F5": .f5,
        "KC_F6": .f6,
        "KC_F7": .f7,
        "KC_F8": .f8,
        "KC_F9": .f9,
        "KC_F10": .f10,
        "KC_F11": .f11,
        "KC_F12": .f12,
    ]
    
    let keyCode = keyCodeMap[text]
    if keyCode == nil {
        throw TextProcessingError.wrongKeyCode(text)
    }
    
    return keyCode!
}

func parseKeyCombinationGroupText(text t: String) throws -> KeyCombination {
    var keyCombination = KeyCombination(keyCode: .alpha0)
    var text = t
    
    if text.hasPrefix("(") {
        text.removeFirst()
    }
    
    if text.hasSuffix(")") {
        text.removeLast()
    }
    
    func isKeyCode(text: String) -> Bool {
        let keyCodeRange = text.range(of: #"KC_[a-zA-Z0-9]+"#, options: .regularExpression)
        return keyCodeRange != nil && keyCodeRange!.contains(text.startIndex)
    }
    
    let keysText = text.split(separator: "+")
    
    for keyText in keysText {
        let keyText = String(keyText)
        guard isKeyCode(text: keyText) else {
            throw TextProcessingError.wrongKeyCodeCombination(keyText)
        }
        
        let keyCode = try parseKeyCodeText(text: keyText)
        if keyCode.isModifier() {
            keyCombination.modifiers.append(keyCode)
        } else {
            keyCombination.keyCode = keyCode
        }
    }
    
    return keyCombination
}

func splitToRows(items: [KeyCombination]) -> [[KeyCombination]] {
    let lines = [[KeyCombination]]()
    
    //    var currentLine = [KeyCombination]()
    //
    //    for item in items {
    //        currentLine.append(item)
    //        if item[0] == .returnKey {
    //            lines.append(currentLine)
    //            currentLine = [KeyCombination]()
    //        }
    //    }
    //
    //    lines.append(currentLine)
    return lines
}

func parseData(text: String) throws -> [Token] {
    
    var result = [Token]()
    
    func getKeysCombinationRange(text: String, from: String.Index) -> Range<String.Index>? {
        return text.range(
            of: #"\((KC_[a-zA-Z0-9]+)(\+(KC_[a-zA-Z0-9]+))*\)"#,
            options: .regularExpression,
            range: from..<text.endIndex
        )
    }

    var nextKeysCombinationRange: Range<String.Index>? = nil
    
    for characterIndex in text.indices {
    
        let character = text[characterIndex]
        let isFirstSearch = (characterIndex == text.startIndex)
        let isMoveToNextToken = (nextKeysCombinationRange != nil && nextKeysCombinationRange!.upperBound == characterIndex)
        
        if isFirstSearch || isMoveToNextToken {
            nextKeysCombinationRange = getKeysCombinationRange(text: text, from: characterIndex)
        }
        
        if nextKeysCombinationRange == nil || !nextKeysCombinationRange!.contains(characterIndex){
            result.append(Token(character))
            continue
        }
        
        if nextKeysCombinationRange!.lowerBound == characterIndex {
            let groupText = String(text[nextKeysCombinationRange!])
            result.append(Token(groupText))
            continue
        }
    }
    
    return result
}
