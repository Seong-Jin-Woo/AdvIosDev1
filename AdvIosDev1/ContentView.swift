//
//  ContentView.swift
//  AdvIosDev1
//
//  Created by Matthew Cruz on 12/9/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var selectedTaskType: TaskType = .personal

    var body: some View {
        NavigationView {
            VStack {
                // Task input field, picker, and add button
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

                // Task list with completion toggle
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Text(task.title)
                                .strikethrough(task.isCompleted, color: .gray)
                                .foregroundColor(task.isCompleted ? .gray : .black)
                            Spacer()
                            Button(action: {
                                // Toggle task completion on button press
                                viewModel.toggleTaskCompletion(task: task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.removeTask)
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                EditButton()
            }
        }
    }
}
