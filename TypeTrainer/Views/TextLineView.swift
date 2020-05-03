//
//  TextLineView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 26.04.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI

struct TextLineView: View {
    var items: [TextItem]
    var body: some View {
        HStack(alignment: .center, spacing: 0.0) {
            ForEach(0..<items.count) { index in
                TextItemView(textItem: self.items[index])
            }
        }.padding(0.0)
        .border(Color.red)
    }
}

struct TextLineView_Previews: PreviewProvider {
    static var previews: some View {
        TextLineView(items: [
            TextItem(token: Token("H")),
            TextItem(token: Token("e")),
            TextItem(token: Token("l")),
            TextItem(token: Token("l")),
            TextItem(token: Token("o")),
            TextItem(token: Token(" ")),
            TextItem(token: Token("(KC_LGUI+KC_A)")),
        ])
    }
}
