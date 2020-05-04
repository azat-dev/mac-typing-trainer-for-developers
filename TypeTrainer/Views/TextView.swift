//
//  TextView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 03.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI

struct TextView: View {
    var data: [[TextItem]]
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            ForEach(0..<data.endIndex) { lineIndex in
                TextLineView(items: self.data[lineIndex])
                .padding(0)
            }
        }
        .padding(0.0)
        .border(Color.orange)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(data: [
            [
                TextItem(token: Token("(KC_LGUI+KC_A)")),
                TextItem(token: Token("(KC_LGUI+KC_A)")),
                TextItem(token: Token("(KC_LGUI+KC_A)"))
            ],
            [
                TextItem(token: Token("(KC_LGUI+KC_A)")),
                TextItem(token: Token("(KC_LGUI+KC_A)")),
                TextItem(token: Token("(KC_LGUI+KC_A)"))
            ],
            [
                TextItem(token: Token("(KC_LGUI+KC_A)")),
                TextItem(token: Token("(KC_LGUI+KC_A)")),
                TextItem(token: Token("(KC_LGUI+KC_A)"))
            ],
            [
                TextItem(token: Token("(KC_LGUI+KC_A)")),
                TextItem(token: Token("(KC_LGUI+KC_A)")),
                TextItem(token: Token("(KC_LGUI+KC_A)"))
            ]
        ])
    }
}
