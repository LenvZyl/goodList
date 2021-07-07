//
//  Task.swift
//  GoodList
//
//  Created by Len van Zyl on 2021/07/07.
//

import Foundation


enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
