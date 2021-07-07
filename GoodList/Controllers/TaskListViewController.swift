//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Len van Zyl on 2021/07/07.
//

import Foundation
import UIKit
import RxSwift

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController, let addTaskViewController = navigationController.viewControllers.first as? AddTaskViewController else{
            fatalError("Controller not found")
        }
        addTaskViewController.taskSubjectObservable.subscribe(onNext: {task in
            
        }).disposed(by: disposeBag)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = "A"
        return cell
    }
    
    
}
