//
//  ContentView.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 26.04.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @EnvironmentObject var appData: AppManager
    
    var body: some View {
        ExerciseView(data: appData.excersizeData)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
