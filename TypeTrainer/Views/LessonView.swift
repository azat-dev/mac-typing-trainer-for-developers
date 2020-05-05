//
//  LessonView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 03.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI

struct LessonView: View {
    @EnvironmentObject var appManager: AppManager
    
    var lesson: Lesson
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if appManager.currentLessonText == nil {
                EmptyView()
            } else {
                TextView(data: appManager.currentLessonText!)
            }
        }.frame(
            minWidth: 0,
            idealWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            idealHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        ).background(Color.white)
        .onAppear {
            self.appManager.setCurrentLesson(lesson: self.lesson)
            self.appManager.startListeningKeyEvents()
        }
        .onDisappear {
            self.appManager.stopListeningKeyEvents()
        }
    }
}


struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(lesson: Lesson(name: "Test", data: []))
        .environmentObject(AppManager())
        .previewDevice("Mac")
    }
}
