import Cocoa

struct KeyEvent: CustomStringConvertible {
    var isKeyUp: Bool
    var keyCode: KeyCode
    var modifiers: [KeyCode]
    
    var keyDescription: String {
        String(UnicodeScalar(keyCode.rawValue))
    }
    
    var modifiersDescription: String {
        modifiers.map({String(UnicodeScalar($0.rawValue))}).joined(separator: "+")
    }
    
    var description: String {
        "KeyEvent: `\(isKeyUp ? "Up" : "Down")  \(keyCode) modifiers: \(modifiers)"
    }
    
    init(isKeyUp: Bool, keyCode: Int64, modifiers: CGEventFlags) {
        self.isKeyUp = isKeyUp
        self.keyCode = KeyCode.init(rawValue: UInt8(keyCode))!
        self.modifiers = [KeyCode]()
        
        if modifiers.contains(.maskCommand) {
            self.modifiers.append(.command)
        }
        
        if modifiers.contains(.maskControl) {
            self.modifiers.append(.leftControl)
        }
        
        if modifiers.contains(.maskShift) {
            self.modifiers.append(.leftShift)
        }
        
        if modifiers.contains(.maskAlternate) {
            self.modifiers.append(.leftAlt)
        }
    }
}
