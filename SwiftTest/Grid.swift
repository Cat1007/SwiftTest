//
//  Grid.swift
//  SwiftTest
//
//  Created by 叶锦浩 on 2020/10/10.
//  Copyright © 2020 叶锦浩. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView

    init(items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                let layout = GridLayout(itemCount: items.count, nearAspectRatio: 1, in: geometry.size)
                viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: items.firstIndex(matching: item)!))
            }
        }
    }
}
