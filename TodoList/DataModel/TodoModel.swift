//
//  TodoModel.swift
//  TodoList
//
//  Created by 浦山秀斗 on 2023/09/04.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    @Persisted var todo: String
    @Persisted var date: String
    @Persisted var category: String
    @Persisted var priority: Int
    
    //Realmが使用するために空の初期値でオブジェクトを作成する。
    convenience override init() {
        self.init(todo: "", date: Date(), category: "", priority: 0)
    }
    
    init(todo: String, date: Date, category: String, priority: Int) {
        self.todo = todo
        self.date = TodoModel.dateFormat(date: date)
        self.category = category
        self.priority = priority
    }
    
    private static func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

