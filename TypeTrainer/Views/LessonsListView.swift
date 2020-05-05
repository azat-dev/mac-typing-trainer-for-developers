//
//  LessonsListView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 04.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI

struct LessonsListView: View {
    var lessons: [Lesson]
    
    var body: some View {
        NavigationView {
            List {
                Text("Lessons")
                    .font(.title)
                    .padding()
                ForEach(lessons, id: \.name) { lesson in
                    NavigationLink(destination: LessonView(lesson: lesson)) {
                        LessonsListItemView(lesson: lesson)
                    }
                }
            }.frame(minWidth: 0, idealWidth: 300, maxWidth: 400)
        }
    }
}

struct LessonsListView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsListView(lessons: [
            Lesson(name: "Lesson", data: []),
            Lesson(name: "Lesson", data: []),
            Lesson(name: "Lesson", data: []),
            Lesson(name: "Lesson", data: []),
            Lesson(name: "Lesson", data: []),
        ])
    }
}
