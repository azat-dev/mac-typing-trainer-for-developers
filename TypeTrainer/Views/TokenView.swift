import SwiftUI

struct TokenView: View {
    var token: Token
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
        TokenView(token: Token(keys: [
            KeyCode("KC_LGUI")
        ]))
    }
}
