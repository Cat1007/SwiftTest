//
//  Array+Identifiable.swift
//  SwiftTest
//
//  Created by 叶锦浩 on 2020/10/10.
//  Copyright © 2020 叶锦浩. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching : Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
