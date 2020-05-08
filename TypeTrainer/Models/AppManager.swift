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
    
    @Published var lessons: [Lesson] = parsedLessons
    @Published var currentLessonText: [[TextItem]]?

    func setCurrentLesson(lesson: Lesson) {
        self.currentLessonText = lesson.data.map { (items) -> [TextItem] in
            items.map { token -> TextItem in TextItem(token: token) }
        }
        
        self.currentLessonText![0][0].isActive = true
    }
    
    func firstItem(where condition: (TextItem, Position) -> Bool) -> (item: TextItem, position: Position)?  {
        for (row, rowItems) in currentLessonText!.enumerated() {
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
        if currentPosition == Position(currentLessonText!.count, currentLessonText!.last!.count) {
            return nil
        }
        
        var nextPosition = Position(currentPosition.row, currentPosition.column + 1)
        if nextPosition.row >= currentLessonText![currentPosition.row].count {
            return nil
        }
        
        if nextPosition.column >= currentLessonText![currentPosition.row].count {
            nextPosition = Position(currentPosition.row + 1, 0)
        }
        
        if nextPosition.row >= currentLessonText![currentPosition.row].count {
            return nil
        }
        
        return nextPosition
    }
    
    func getPrevItemPosition(currentPosition: Position) -> Position? {
        if currentPosition == Position(0, 0) {
            return nil
        }
        
        var prevPosition = Position(currentPosition.row, currentPosition.column - 1)
        if prevPosition.row < 0 {
            return nil
        }
        
        if prevPosition.column < 0 {
            prevPosition = Position(
                currentPosition.row - 1,
                currentLessonText![currentPosition.row - 1].count - 1
            )
        }
        
        if prevPosition.row < 0 {
            return nil
        }
        
        return prevPosition
    }
    
    func updateItems(change: (_ position: Position, _ item: TextItem) -> TextItem ) {
        for (row, rowItems) in currentLessonText!.enumerated() {
            for (column, item) in rowItems.enumerated() {
                self.currentLessonText![row][column] = change(Position(row, column), item)
            }
        }
    }
    
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

        let activeItemData = getActiveItem()
        if activeItemData == nil {
            return true
        }
        
        let (activeItem, activeItemPosition) = activeItemData!
        
        var markWrong = false
        var markCompleted = false
        
        
        let isRightInput = isRightKeyCombination(keyEvent: keyEvent, activeItem: activeItem)
        let isDelete = (keyEvent.keyCode == .backspace && keyEvent.modifiers.isEmpty)
        
        var nextPosition: Position? = activeItemPosition
        
        if isDelete {
            
            markCompleted = false
            markWrong = false
            
            nextPosition = getPrevItemPosition(currentPosition: activeItemPosition)
        
        } else if isRightInput {
        
            markCompleted = true
            markWrong = false
            nextPosition = getNextItemPosition(currentPosition: activeItemPosition)
            
        } else {
        
            markWrong = true
            markCompleted = false
            nextPosition = getNextItemPosition(currentPosition: activeItemPosition)
        }
        
        if nextPosition == nil {
            return true
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

func unifyKeyCodes(_ keyCodes: [KeyCode]) -> Set<KeyCode> {
    let modifiersMapping: [KeyCode: KeyCode] = [
        .leftShift: .leftShift,
        .rightShift: .leftShift,
        
        .leftAlt: .leftAlt,
        .rightAlt: .leftAlt,
        
        .leftControl: .leftControl,
        .rightControl: .leftControl,
        
        .command: .command,
        
        .alpha0: .alpha0,
        .alpha1: .alpha1,
        .alpha2: .alpha2,
        .alpha3: .alpha3,
        .alpha4: .alpha4,
        .alpha5: .alpha5,
        .alpha6: .alpha6,
        .alpha7: .alpha7,
        .alpha8: .alpha8,
        .alpha9: .alpha9,
        
        .numpad0: .alpha0,
        .numpad1: .alpha1,
        .numpad2: .alpha2,
        .numpad3: .alpha3,
        .numpad4: .alpha4,
        .numpad5: .alpha5,
        .numpad6: .alpha6,
        .numpad7: .alpha7,
        .numpad8: .alpha8,
        .numpad9: .alpha9,
    ]
    
    let unified = keyCodes.map { modifiersMapping[$0] ?? $0 }
    return Set(unified)
}

func compareKeyCodes(_ keyCodes1: [KeyCode], _ keyCode2: [KeyCode]) -> Bool {
    return unifyKeyCodes(keyCodes1) == unifyKeyCodes(keyCode2)
}

func isRightKeyCombination(keyEvent: KeyEvent, activeItem: TextItem) -> Bool {

    let rightKeyCombinations = activeItem.token.rightKeyCombinations
    let rightKeyCombination = rightKeyCombinations.first { keyCombination in
        return compareKeyCodes([keyCombination.keyCode], [keyEvent.keyCode]) &&
            compareKeyCodes(keyEvent.modifiers, keyCombination.modifiers)
    }
    
    return rightKeyCombination != nil
}
