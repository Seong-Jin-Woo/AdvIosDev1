//
//  TaskRowView.swift
//  AdvIosDev1
//
//  Created by Matthew Cruz on 16/9/2024.
//

import SwiftUI

struct TaskRowView: View {
    @ObservedObject var task: Task  // Observes changes to a task
    @Binding var isEditingNames: Bool  // Tracks name edit mode state
    @Binding var isDeleting: Bool  // Tracks delete mode state
    @State private var editedTaskTitle: String = ""  // Stores the edited task title
    var viewModel: TaskViewModel  // ViewModel for managing tasks
    
    var body: some View {
        HStack {
            if isDeleting {
                // Show delete button when in delete mode
                Button(action: {
                    if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                        viewModel.tasks.remove(at: index)  // Remove the task
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
            }

            if isEditingNames {
                // Name editing mode
                TextField("Edit task", text: $editedTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onAppear {
                        editedTaskTitle = task.title  // Pre-fill the text field with the current title
                    }
                
                // Save the edited title
                Button("Save") {
                    if !editedTaskTitle.isEmpty {
                        task.title = editedTaskTitle
                    }
                    isEditingNames = false  // Exit edit mode after saving
                }
            } else {
                // Normal Mode: Display the task title and the task completion checkmark
                Text("\(task.title) (\(task.type))")
                    .strikethrough(task.isCompleted, color: .gray)
                    .foregroundColor(task.isCompleted ? .gray : .black)
                
                Spacer()

                // Task completion button (checkmark or circle)
                Button(action: {
                    task.toggleCompletion()  // Toggle task completion
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                }
                .padding(.trailing, 10)  // Ensure proper spacing
            }
        }
    }
}
