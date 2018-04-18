//
//  ToDoTask.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation

public struct ToDoTaskResponse: Codable {
    let objects: [ToDoTask]
}

public struct LocalToDoTask: Codable {
    let group: String?
    let title: String
    let description: String?
}

public struct ToDoTask: Codable {
    public let group: String?
    public let title: String
    public let description: String?
    public let priority: Priority
    public let done: Bool

    public init(group: String?,
                title: String,
                description: String?,
                priority: Priority,
                done: Bool) {
        self.group = group
        self.title = title
        self.description = description
        self.priority = priority
        self.done = done
    }

    public enum Priority: String, Codable, Comparable {
        case low = "low"
        case medium = "med"
        case high = "high"

        public static func < (left: Priority, right: Priority) -> Bool {
            if left == right {
                return false
            }

            switch left {
            case low:
                return true
            case .medium:
                return right == .high
            case .high:
                switch right {
                case .high:
                    return true
                case .low, .medium:
                    return false
                }
            }
        }
    }
}
