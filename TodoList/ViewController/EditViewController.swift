//
//  EditViewController.swift
//  TodoList
//
//  Created by 浦山秀斗 on 2023/09/04.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet var priorityButtons: [UIButton]!
    
    public var selectedTodo: TodoModel?
    
    private let viewModel = EditiewModel(repository: TodoRepository())
    private var newTodo: TodoModel!
    private var isBothTextFieldsFilled = false
    private var buttonStates: Array<Bool> = Array(repeating: false, count: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTodo = TodoModel()
        setDefaultValue()
        todoField.delegate     = self
        categoryField.delegate = self
        
        navigationItem.title = selectedTodo == nil ? "Todo作成" : "Todo編集"
    }
    
    @IBAction func save() {
        guard isBothTextFieldsFilled else {
            showAlert()
            return
        }
        
        newTodo.priority = countingPriority()
        
        if selectedTodo == nil {
            viewModel.addTodo(todo: newTodo)
        } else {
            viewModel.updateTodo(todo: selectedTodo!, updateTodo: newTodo)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func priorityButtonTapped(_ sender: AnyObject) {
        let priorityButton = sender as! UIButton
        buttonStates[priorityButton.tag].toggle()
        if buttonStates[priorityButton.tag] {
            priorityButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            priorityButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    private func countingPriority() -> Int {
        var count = 0
        
        buttonStates.forEach { buttonState in
            if buttonState {
                count += 1
            }
        }
        
        return count
    }
    
    private func setDefaultValue() {
        todoField.text = selectedTodo?.todo ?? ""
        categoryField.text = selectedTodo?.category ?? ""
        newTodo.todo = selectedTodo?.todo ?? ""
        newTodo.category = selectedTodo?.category ?? ""
        isBothTextFieldsFilled = true
        newTodo.priority = selectedTodo?.priority ?? 0
        print(newTodo!)
        for i in 0 ..< newTodo.priority {
            buttonStates[i] = true
        }
        setImage()
    }
    
    private func setImage() {
        for i in 0 ..< buttonStates.count {
            if buttonStates[i] {
                priorityButtons[i].setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                priorityButtons[i].setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    private func showAlert() {
        let alert = UIAlertController(title: "ERROR", message: "テキストフィールドに値が設定されていません。", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}


extension EditViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        newTodo.todo     = todoField.text ?? ""
        newTodo.category = categoryField.text ?? ""
        let isFill_all   = !(newTodo.todo.isEmpty || newTodo.category.isEmpty)
        
        isBothTextFieldsFilled = isFill_all
        return true
    }
}
