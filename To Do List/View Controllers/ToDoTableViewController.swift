//
//  ToDoTableViewController.swift
//  To Do List
//
//  Created by Ayu Filippova on 12/08/2019.
//  Copyright © 2019 Dmitry Filippov. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var todos = [ToDo]()
    
    //MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = [
            ToDo(title: "Купить хлеб", image: UIImage(named: "bread" )),
            ToDo(title: "Записать ребенка в школу", image: UIImage(named: "school" )),
            ToDo(title: "Подготовить питч", image: UIImage(named: "pitch" ))
        ]
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        let todo = todos[indexPath.row]
        configure(cell, with: todo)
        return cell
    }
    
    // MARK: - Cell Content
    func configure(_ cell: ToDoCell, with todo: ToDo) {
        guard let stackView = cell.stackView else { return }
        guard stackView.arrangedSubviews.count == 0 else { return }
        
        for index in 0 ..< todo.keys.count {
            let key = todo.capitalizedKeys[index]
            let value = todo.values[index]
            
            if let stringValue = value as? String {
                
                let label = UILabel()
                label.text = "\(key): \(stringValue)"
                stackView.addArrangedSubview(label)
                
            } else if let dateValue = value as? Date {
                
                let label = UILabel()
                label.text = "\(key): \(dateValue.formattedDate)"
                stackView.addArrangedSubview(label)
                
            } else if let boolValue = value as? Bool {
                
                let label = UILabel()
                label.text = "\(key): \(boolValue ? "✅" : "⚪️")"
                stackView.addArrangedSubview(label)
                
            } else if let imageValue = value as? UIImage {
                
                let imageView = UIImageView(image: imageValue)
                imageView.contentMode = .scaleAspectFit
                let heightConstraint = NSLayoutConstraint(
                    item: imageView,
                    attribute: .height,
                    relatedBy: .equal,
                    toItem: nil,
                    attribute: .height,
                    multiplier: 1,
                    constant: 200
                )
                imageView.addConstraint(heightConstraint)
                stackView.addArrangedSubview(imageView)
                
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToDoItemSegue" else { return }
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
        let destination = segue.destination as! ToDoItemTableViewController
        /* чтобы избежать возможных проблем со ссылочным характером класса (ToDo объявлен классом)
         в модели прописали функцию copy() и применяем при передаче информации на следующий вьюконтроллер
         и конвертируем его в ToDo -  as! ToDo
        */
        destination.todo = todos[selectedIndex.row].copy() as! ToDo
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveSegue" else { return }
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
        let source = segue.source as! ToDoItemTableViewController
        /* здесь получится, что старое значение todo в массиве todos под указанным индексом уничтожится, а новое значение присвоится.
         при этом не будет утечки памяти (тк старое значение уничтожится благодаря ARC)
        */
        todos[selectedIndex.row] = source.todo
        if let toDoCell = tableView.cellForRow(at: selectedIndex) as? ToDoCell {
            if let stackView = toDoCell.stackView {
                stackView.arrangedSubviews.forEach { subview in
                    stackView.removeArrangedSubview(subview)
                    subview.removeFromSuperview()
                }
            }
            
        }
        tableView.reloadRows(at: [selectedIndex], with: .automatic)
    }
}

