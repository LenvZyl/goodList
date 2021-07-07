//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Len van Zyl on 2021/07/07.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    private let tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController, let addTaskViewController = navigationController.viewControllers.first as? AddTaskViewController else{
            fatalError("Controller not found")
        }
        addTaskViewController.taskSubjectObservable.subscribe(onNext: { task in
            let priority = Priority(rawValue: self.segmentedController.selectedSegmentIndex - 1)
            
            self.tasks.accept(self.tasks.value + [task])
            self.filterTasks(by: priority)
        }).disposed(by: disposeBag)
        
    }
    
    private func filterTasks(by priority: Priority?){
        if priority == nil {
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        }else{
            self.tasks.map { tasks in
                return tasks.filter{ $0.priority == priority! }}.subscribe(onNext: { [weak self] tasks in
                    self?.filteredTasks = tasks
                    self?.updateTableView()
                }
            ).disposed(by: disposeBag)
        }
    }
    private func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func filterAction(segmentedControl: UISegmentedControl) {
        let priority = Priority(rawValue: self.segmentedController.selectedSegmentIndex - 1)
        self.filterTasks(by: priority)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
    }
    
    
}
