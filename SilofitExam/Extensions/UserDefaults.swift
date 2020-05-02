//
//  UserDefaults.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

extension UserDefaults {
    func read<T>(at key: String) -> T? {
        return value(forKey: key) as? T
    }

    func set<T>(data: T, at key: String) {
        set(data, forKey: key)
    }
}
