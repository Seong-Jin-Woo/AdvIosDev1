//
//  ContentView.swift
//  AdvIosDev1
//
//  Created by Matthew Cruz on 12/9/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()  // ViewModel for managing tasks
    @State private var newTaskTitle = ""  // Input for new task title
    @State private var selectedTaskType: TaskType = .personal  // Default task type
    @State private var isEditingNames = false  // Edit mode toggle
    @State private var isDeleting = false  // Delete mode toggle
    
    var body: some View {
        NavigationView {
            VStack {
                // Add Task UI
                HStack {
                    TextField("Enter task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("Type", selection: $selectedTaskType) {
                        Text("Personal").tag(TaskType.personal)
                        Text("Work").tag(TaskType.work)
                        Text("Shopping").tag(TaskType.shopping)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if !newTaskTitle.isEmpty {
                            viewModel.addTask(title: newTaskTitle, type: selectedTaskType)
                            newTaskTitle = ""
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
                .padding()
                
                // Display the list of tasks
                List {
                    ForEach(viewModel.tasks, id: \.id) { task in
                        TaskRowView(task: task, isEditingNames: $isEditingNames, isDeleting: $isDeleting, viewModel: viewModel)
                    }
                    .onDelete(perform: viewModel.removeTask)
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                // Edit button for renaming tasks
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(isEditingNames ? "Done" : "Rename") {
                        isEditingNames.toggle()
                        if isEditingNames {
                            isDeleting = false
                        }
                    }
                }
                
                // Delete button for selecting tasks to delete
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isDeleting ? "Done" : "Delete") {
                        isDeleting.toggle()
                        if isDeleting {
                            isEditingNames = false
                        }
                    }
                }
            }
        }
    }
}
