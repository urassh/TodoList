//
//  ViewController.swift
//  TodoList
//
//  Created by 浦山秀斗 on 2023/09/04.
//

import UIKit

//やること
//カテゴリ絞る機能

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    private var todoArray: Array<TodoModel> = []
    private var selectTodo: TodoModel?
    private let viewModel = TodoListViewModel(repository: TodoRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate   = self
        todoArray = viewModel.getAllTodos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditView" {
            let editVC = segue.destination as! EditViewController
            editVC.selectedTodo = sender as? TodoModel
        }
    }
    
    private func reloadView() {
        todoArray = viewModel.getAllTodos()
        tableView.reloadData()
    }
    
    private func presentCategorySheet(_ action: () -> Void) {
        let alert = UIAlertController(title: "カテゴリー選択", message: "カテゴリーを選択してください", preferredStyle: .actionSheet)
        
        todoArray.forEach { todo in
            let category = UIAlertAction(title: todo.category, style: .default) { action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(category)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func presentDeleteSheet(todo: TodoModel, _ delete: @escaping () -> Void) {
        let todoMessage = "Todo: \(todo.todo)\n Category: \(todo.category)\n Priority: \(todo.priority)"
        let alert = UIAlertController(title: "本当にTodoを削除しますか？", message: todoMessage, preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "削除", style: .destructive) { (action) in
            delete()
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        let item: TodoModel = todoArray[indexPath.row]
        cell.setCell(priority: item.priority, title: item.todo, date: item.date)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectTodo = self.todoArray[indexPath.row]
        self.performSegue(withIdentifier: "toEditView", sender: self.selectTodo)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "編集") { (action, view, completionHandler) in
            self.selectTodo = self.todoArray[indexPath.row]
            self.performSegue(withIdentifier: "toEditView", sender: self.selectTodo)
            completionHandler(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "削除") { (action, view, completionHandler) in
            let deleteTodo = self.todoArray[indexPath.row]
            
            self.presentDeleteSheet(todo: deleteTodo) {
                self.viewModel.deleteTodo(todo: deleteTodo)
                self.reloadView()
            }
            
            completionHandler(true)
         }
        
        editAction.backgroundColor = UIColor.systemBlue
        editAction.image   = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle))
        deleteAction.image = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle))
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
