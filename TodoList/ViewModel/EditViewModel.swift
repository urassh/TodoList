//
//  EditViewModel.swift
//  TodoList
//
//  Created by 浦山秀斗 on 2023/09/05.
//

import Foundation
import RealmSwift

class EditiewModel {
    private var repository: TodoRepository
    
    init(repository: TodoRepository) {
        self.repository = repository
    }
    
    func addTodo(todo: TodoModel) {
        repository.addTodo(todo: todo)
    }
    
    func updateTodo(todo: TodoModel, updateTodo: TodoModel) {
        repository.updateTodo(todo: todo, updateTodo: updateTodo)
    }
}
