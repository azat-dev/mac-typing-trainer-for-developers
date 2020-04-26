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
    
    init(_ value: Character) {
        self.value = String(value)
    }
}
