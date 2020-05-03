//
//  AppData.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 04.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//

import Foundation


final class AppManager: ObservableObject {
    struct Position: Equatable {
        var row: Int
        var column: Int
        
        init(_ row: Int, _ column: Int) {
            self.row = row
            self.column = column
        }
    }
    
    @Published var excersizeData: [[TextItem]]
    
    init() {
        self.excersizeData = AppManager.getData()
    }
    
    static func getData() -> [[TextItem]] {
        var result = typeData.map { (items) -> [TextItem] in
            items.map { token -> TextItem in TextItem(token: token) }
        }
        
        result[0][0].isActive = true
        return result
    }
    
    func firstItem(where condition: (TextItem, Position) -> Bool) -> (item: TextItem, position: Position)?  {
        for (row, rowItems) in excersizeData.enumerated() {
            for (column, item) in rowItems.enumerated() {
                let position = Position(row, column)
                if condition(item, position) {
                    return (item, position)
                }
            }
        }
        
        return nil
    }
    
    func getActiveItem() -> (TextItem, Position)? {
        return self.firstItem { (item, _) in item.isActive }
    }
    
    func getNextItemPosition(currentPosition: Position) -> Position? {
        var nextPosition = Position(currentPosition.row, currentPosition.column + 1)
        
        if nextPosition.column >= excersizeData[currentPosition.row].count {
            nextPosition = Position(currentPosition.row + 1, 0)
        }
        
        
        if nextPosition.row >= excersizeData[currentPosition.row].count {
            return nil
        }
        
        return nextPosition
    }
    
    func getPrevItemPosition(currentPosition: Position) -> Position? {
        var nextPosition = Position(currentPosition.row, currentPosition.column - 1)
        
        if nextPosition.column < 0 {
            nextPosition = Position(currentPosition.row - 1, self.excersizeData[currentPosition.row - 1].count - 1)
        }
        
        
        if nextPosition.row < 0 {
            return nil
        }
        
        return nextPosition
    }
    
    func updateItems(change: (_ position: Position, _ item: TextItem) -> TextItem ) {
        for (row, rowItems) in excersizeData.enumerated() {
            for (column, item) in rowItems.enumerated() {
                self.excersizeData[row][column] = change(Position(row, column), item)
            }
        }
    }

//
//    func moveToNext() {
//        let (_, activePosition) = self.getActiveItem()!
//        let nexPosition = self.getNextItemPosition(currentPosition: activePosition)!
//        print("NExt \(nexPosition)")
//
//        self.updateItems { (position, item) -> TextItem in
//            var newItem = item
//            newItem.isActive = (position == nexPosition)
//            return newItem
//        }
//    }
    
    func markAsWrong(position itemPosition: Position) {
        updateItems { (position, item) -> TextItem in
            var newItem = item
            if position == itemPosition {
                newItem.isWrongTyped = true
            }
            
            return newItem
        }
    }
    
    func markAsCompleted(position itemPosition: Position) {
        updateItems { (position, item) -> TextItem in
            var newItem = item
            if position == itemPosition {
                newItem.isWrongTyped = false
                newItem.isCompleted = true
            }
            
            return newItem
        }
    }
    
    func onKeyEvent(_ keyEvent: KeyEvent) -> Bool {
        if keyEvent.isKeyUp {
            return true
        }

        let (activeItem, activeItemPosition) = self.getActiveItem()!
        
        var markWrong = false
        var markCompleted = false
        
        let isRightInput = true
        let isDelete = (keyEvent.keyCode == .backspace && keyEvent.modifiers.isEmpty)
        
        var nextPosition: Position = activeItemPosition
        
        if !isRightInput {
            markWrong = true
        } else {
            if isDelete {
                markCompleted = false
                markWrong = false
                nextPosition = getPrevItemPosition(currentPosition: activeItemPosition)!
            } else {
                markCompleted = true
                markWrong = false
                nextPosition = getNextItemPosition(currentPosition: activeItemPosition)!
            }
        }

        
        updateItems { (position, item) in
            var newItem = item
            newItem.isActive = false

            if position == nextPosition {
                newItem.isActive = true
            }
            
            if position == activeItemPosition {
                newItem.isWrongTyped = markWrong
                newItem.isCompleted = markCompleted
            }
            
            return newItem
        }
        
        return true
    }
}
