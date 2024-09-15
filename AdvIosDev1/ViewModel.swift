//
//  ViewModel.swift
//  AdvIosDev1
//
//  Created by Matthew Cruz on 15/9/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []  // Store tasks as Task objects
    
    // Add a new task based on the selected task type
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
    
    // Remove a task by index set
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
