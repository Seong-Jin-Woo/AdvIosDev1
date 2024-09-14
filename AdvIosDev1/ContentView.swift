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
                
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Text(task.title)
                                .strikethrough(task.isCompleted, color: .gray)
                                .foregroundColor(task.isCompleted ? .gray : .black)
                            Spacer()
                            Button(action: {
                                viewModel.toggleTaskCompletion(task: task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                        }
                        .onTapGesture {
                            viewModel.toggleTaskCompletion(task: task) // Immediate toggle on tap
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
