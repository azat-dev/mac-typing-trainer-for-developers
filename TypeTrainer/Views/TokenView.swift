import SwiftUI

struct TokenView: View {
    var data: DisplayToken
    
    var representation: String {
        switch token.token {
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
        case let value where value.hasPrefix("KC_"):
            return value.dropFirst("KC_".count).uppercased()
        default:
            return value
        }
    }
    
    var body: some View {
        VStack {
            Text(token.representation)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(1.0)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .padding(/*@START_MENU_TOKEN@*/.vertical, 5.0/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TokenView_Previews: PreviewProvider {
    static var previews: some View {
        TokenView(token:
            DisplayToken(token:
                Token(text: "a")
            )
        )
    }
}
