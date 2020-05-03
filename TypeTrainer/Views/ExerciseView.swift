//
//  ExerciseView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 03.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI

struct ExerciseView: View {
    var data: [[TextItem]]
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TextView(data: data)
            .padding(0)
        }.frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(data: typeData.map { (items) -> [TextItem] in
            items.map { token -> TextItem in TextItem(token: token) }
        })
    }
}
