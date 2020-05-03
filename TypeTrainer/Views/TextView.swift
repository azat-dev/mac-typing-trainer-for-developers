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
        VStack {
            ForEach(0..<data.endIndex) { lineIndex in
                TextLineView(items: self.data[lineIndex])
            }
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(data: typeData)
    }
}
