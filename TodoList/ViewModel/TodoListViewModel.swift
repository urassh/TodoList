//
//  ViewModel.swift
//  TodoList
//
//  Created by 浦山秀斗 on 2023/09/05.
//

import Foundation
import RealmSwift

class TodoListViewModel {
    private var repository: TodoRepository
    
    init(repository: TodoRepository) {
        self.repository = repository
    }
    
    func getAllTodos() -> Array<TodoModel> {
        return repository.getAllTodos()
    }
    
    func deleteTodo(todo: TodoModel) {
        repository.deleteTodo(todo: todo)
    }
}
