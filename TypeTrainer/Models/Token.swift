struct Token {
    var keys: [KeyCode] = []
    var isTyped = false
    var isWrong = false
    
    init() {
    }
    
    init(character: Character) {
        keys.append(KeyCode(character))
    }
    
    init(keys: [KeyCode]) {
        self.keys = keys
    }
    
    var representation: String {
        if keys.count == 1 {
            return keys[0].representation
        }
        
        return "(\(keys.map({ $0.representation }).joined(separator: "+")))"
    }
}
