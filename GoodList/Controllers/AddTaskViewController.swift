//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Len van Zyl on 2021/07/07.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        return taskSubject
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        guard let priority = Priority(rawValue: self.segmentedController.selectedSegmentIndex),
        let title = self.nameTextField.text else {
            return
        }
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }
}
