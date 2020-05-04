//
//  LessonsListItemView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 04.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI

struct LessonsListItemView: View {
    var lesson: Lesson
    
    var body: some View {
        HStack {
            Text(lesson.name)
                .font(.subheadline)
        }.padding()
    }
}

struct LessonsListItemView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsListItemView(lesson: Lesson(name: "Command key and A", data: []))
            .previewLayout(.fixed(width: 350, height: 70))
    }
}
