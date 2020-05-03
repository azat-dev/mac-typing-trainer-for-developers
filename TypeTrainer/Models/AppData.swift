//
//  AppData.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 04.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import Foundation


final class AppData: ObservableObject {
    @Published var excersizeData: [[TextItem]]
    
    init() {
        self.excersizeData = AppData.getData()
    }
    
    static func getData() -> [[TextItem]] {
        var result = typeData.map { (items) -> [TextItem] in
            items.map { token -> TextItem in TextItem(token: token) }
        }
        
        result[0][0].isActive = true
        return result
    }
    
    func getActiveItemPosition() -> (x: Int, y: Int)? {
        for (y, row) in excersizeData.enumerated() {
            for (x, item) in row.enumerated() {
                if item.isActive {
                    return (x: x, y: y)
                }
            }
        }
        
        return nil
    }
    
    func getNextItemPosition(currentPosition: (x: Int, y: Int)) -> (x: Int, y: Int)? {
        var nextPosition = (x: currentPosition.x + 1, y: currentPosition.y)
        
        if nextPosition.x >= excersizeData[currentPosition.y].count {
            nextPosition = (x: 0, y: currentPosition.y + 1)
        }
        
        
        if nextPosition.y >= excersizeData[currentPosition.y].count {
            return nil
        }
        
        return nextPosition
    }
    
    func updateItem(change: (_ position: (x: Int, y: Int), _ item: TextItem) -> TextItem ) {
        for (y, row) in excersizeData.enumerated() {
            for (x, item) in row.enumerated() {
                self.excersizeData[y][x] = change((x: x, y: y), item)
            }
        }
    }
    
    func moveToNext() {
        let activePosition = self.getActiveItemPosition()!
        let nexPosition = self.getNextItemPosition(currentPosition: activePosition)!
        print("NExt \(nexPosition)")
        
        self.updateItem { (position, item) -> TextItem in
            var newItem = item
            newItem.isActive = (position == nexPosition)
            return newItem
        }
    }
    
    func onKeyEvent(_ keyEvent: KeyEvent) -> Bool {
        self.moveToNext()
        return true
    }
}
