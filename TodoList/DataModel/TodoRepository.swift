//
//  TodoRepository.swift
//  TodoList
//
//  Created by 浦山秀斗 on 2023/09/05.
//

import RealmSwift

class TodoRepository {
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    // Todoデータを追加
    func addTodo(todo: TodoModel) {
        try! realm.write {
            realm.add(todo)
        }
    }
    
    // Todoデータを更新
    func updateTodo(todo: TodoModel, updateTodo: TodoModel) {
        deleteTodo(todo: todo)
        addTodo(todo: updateTodo)
    }
    
    // Todoデータを削除
    func deleteTodo(todo: TodoModel) {
        try! realm.write {
            realm.delete(todo)
        }
    }
    
    // 全てのTodoデータを取得
    func getAllTodos() -> Array<TodoModel> {
        return Array(realm.objects(TodoModel.self))
    }
}
