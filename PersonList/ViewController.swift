//
//  ViewController.swift
//  PersonList
//
//  Created by Nam Le on 5/22/20.
//  Copyright © 2020 Nam Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var persons = [Person]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        persons = fakeData()
        title = "List item"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPerson))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addPerson() {
        let vc = CreatePersonViewController()
        vc.passData = { [weak self] data in
            guard let strongSelf = self else { return}
            strongSelf.persons.append(data)
            strongSelf.tableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.person = persons[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completion) in
            let vc = CreatePersonViewController()
            vc.personCurrent = self.persons[indexPath.row]
            vc.passData = { [weak self] data in
                guard let strongSelf = self else { return}
                strongSelf.persons[indexPath.row] = data
                strongSelf.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        let delete = UIContextualAction(style: .normal, title: "Delete") {
            (action, view, completion) in
            self.persons.remove(at: indexPath.row)
            tableView.reloadData()
        }
        edit.backgroundColor = .cyan
        delete.backgroundColor = .orange
        let configuration = UISwipeActionsConfiguration(actions: [edit,delete])
        return configuration
    }
}

