//
//  Model.swift
//  AdvIosDev1
//
//  Created by Matthew Cruz on 15/9/2024.
//

import Foundation

// Protocol for task
protocol TaskProtocol {
    var title: String { get set }
    var isCompleted: Bool { get set }
    func toggleCompletion()
}

// Base Task class
class Task: TaskProtocol, Identifiable, ObservableObject {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    func toggleCompletion() {
        isCompleted.toggle()
    }
}

// Subclass for task types (e.g., personal, work)
class PersonalTask: Task { }
class WorkTask: Task { }
class ShoppingTask: Task { }
