//
//  Model.swift
//  AdvIosDev1
//
//  Created by Matthew Cruz on 15/9/2024.
//

import Foundation

// Protocol for task
protocol TaskProtocol: AnyObject {
    var id: UUID { get }
    var title: String { get set }
    var isCompleted: Bool { get set }
    var type: String { get }
    func toggleCompletion()
}

// Base Task class
class Task: TaskProtocol, Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var title: String
    @Published var isCompleted: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    var type: String {  
        return "Task"
    }

    func toggleCompletion() {
        isCompleted.toggle()
    }
}

// Subclasses for different task types with specific `type` strings
class PersonalTask: Task {
    override var type: String {
        return "Personal"
    }
}

class WorkTask: Task {
    override var type: String {
        return "Work"
    }
}

class ShoppingTask: Task {
    override var type: String {
        return "Shopping"
    }
}

enum TaskType {
    case personal, work, shopping
}
