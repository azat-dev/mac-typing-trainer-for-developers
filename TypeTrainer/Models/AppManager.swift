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
    
    var isKeyEventListenerActive = false
    
    
    @Published var lessons: [Lesson] = parsedLessons
    @Published var currentLessonText: [[TextItem]]?

    func setCurrentLesson(lesson: Lesson) {
        self.currentLessonText = lesson.data.map { (items) -> [TextItem] in
            items.map { token -> TextItem in TextItem(token: token) }
        }
    }
    
    func startListeningKeyEvents() {
        self.isKeyEventListenerActive = true
    }
    
    func stopListeningKeyEvents() {
        self.isKeyEventListenerActive = false
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
        var nextPosition = Position(currentPosition.row, currentPosition.column + 1)
        
        if nextPosition.column >= currentLessonText![currentPosition.row].count {
            nextPosition = Position(currentPosition.row + 1, 0)
        }
        
        
        if nextPosition.row >= currentLessonText![currentPosition.row].count {
            return nil
        }
        
        return nextPosition
    }
    
    func getPrevItemPosition(currentPosition: Position) -> Position? {
        var nextPosition = Position(currentPosition.row, currentPosition.column - 1)
        
        if nextPosition.column < 0 {
            nextPosition = Position(currentPosition.row - 1, self.currentLessonText![currentPosition.row - 1].count - 1)
        }
        
        
        if nextPosition.row < 0 {
            return nil
        }
        
        return nextPosition
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
        if !isKeyEventListenerActive {
            return false
        }
        
        if keyEvent.isKeyUp {
            return true
        }

        let (activeItem, activeItemPosition) = self.getActiveItem()!
        
        var markWrong = false
        var markCompleted = false
        
        func unifyModifiers(modifiers: [KeyCode]) -> Set<KeyCode> {
            let modifiersMapping: [KeyCode: KeyCode] = [
                .leftShift: .leftShift,
                .rightShift: .leftShift,
                
                .leftAlt: .leftAlt,
                .rightAlt: .leftAlt,
                
                .leftControl: .leftControl,
                .rightControl: .leftControl,
                
                .command: .command
            ]
            
            let unified = modifiers.map { modifiersMapping[$0]! }
            return Set(unified)
        }
        
        let rightKeyCombinations = activeItem.token.rightKeyCombinations
        
        let rightKeyCombination = rightKeyCombinations.first { keyCombination in
            
            let keyCombinationModifiersSet = unifyModifiers(modifiers: keyCombination.modifiers)
            let eventModifiersSet = unifyModifiers(modifiers: keyEvent.modifiers)
            
            return keyCombination.keyCode == keyEvent.keyCode &&
                keyCombinationModifiersSet == eventModifiersSet
            
        }
        
        let isRightInput = (rightKeyCombination != nil)
        let isDelete = (keyEvent.keyCode == .backspace && keyEvent.modifiers.isEmpty)
        
        var nextPosition: Position = activeItemPosition
        
        if isDelete {
            
            markCompleted = false
            markWrong = false
            nextPosition = getPrevItemPosition(currentPosition: activeItemPosition)!
        
        } else if isRightInput {
        
            markCompleted = true
            markWrong = false
            nextPosition = getNextItemPosition(currentPosition: activeItemPosition)!
            
        } else {
        
            markWrong = true
            markCompleted = false
            nextPosition = getNextItemPosition(currentPosition: activeItemPosition)!
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
