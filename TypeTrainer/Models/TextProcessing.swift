import Foundation

enum TokenError: Error {
    case wrongKeyCodeCombination(String)
}

func splitKeysCombination(text t: String) throws -> [KeyCode] {
    var keys = [KeyCode]()
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
            throw TokenError.wrongKeyCodeCombination(keyText)
        }
        
        keys.append(KeyCode(keyText))
    }
    
    return keys
}

func splitToLines(tokens: [Token]) -> [[Token]] {
    var lines = [[Token]]()
    
    var currentLine = [Token]()
    
    for token in tokens {
        currentLine.append(token)
        if token.keys[0].value == "\n" || token.keys[0].value == "KC_ENT" {
            lines.append(currentLine)
            currentLine = [Token]()
        }
    }
    
    lines.append(currentLine)
    return lines
}

func getTokens(text t: String) throws -> [Token] {

    var tokens = [Token]()
    var text = t;
    
    func getKeysCombinationRange(text: String) -> Range<String.Index>? {
        return text.range(of: #"\((KC_[a-zA-Z0-9]+)(\+(KC_[a-zA-Z0-9]+))*\)"#, options: .regularExpression)
    }

    while text.count > 0 {

        let keysCombinationRange = getKeysCombinationRange(text: text)
        
        if keysCombinationRange == nil || !keysCombinationRange!.contains(text.startIndex) {
            tokens.append(Token(character: text.removeFirst()))
            continue
        }
        
        let keysCombinationText = String(text[keysCombinationRange!])
        let keysCombination = try! splitKeysCombination(text: keysCombinationText)

        tokens.append(Token(keys: keysCombination))
        text.removeSubrange(keysCombinationRange!)
    }

    return tokens
}
