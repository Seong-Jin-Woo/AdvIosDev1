//
//  ViewModel.swift
//  AdvIosDev1
//
//  Created by Matthew Cruz on 15/9/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    // Published array of tasks
    @Published var tasks: [Task] = []
    
    // Add a new task
    func addTask(title: String, type: TaskType) {
        let task: Task
        switch type {
        case .personal:
            task = PersonalTask(title: title)
        case .work:
            task = WorkTask(title: title)
        case .shopping:
            task = ShoppingTask(title: title)
        }
        tasks.append(task)
    }
    
    // Remove task
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // Toggle task completion
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].toggleCompletion()
        }
    }
}

// Enum to represent task types
enum TaskType {
    case personal, work, shopping
}
