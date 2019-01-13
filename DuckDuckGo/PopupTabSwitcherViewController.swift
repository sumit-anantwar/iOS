//
//  PopupTabSwitcherViewController.swift
//  DuckDuckGo
//
//  Created by Christopher Brind on 13/01/2019.
//  Copyright © 2019 DuckDuckGo. All rights reserved.
//

import UIKit

class PopupTabSwitcherViewController: UICollectionViewController {

    enum Action {

        case newTab
        case switchToTab(atIndex: Int)
        case manageTabs

    }

    lazy var model = TabsModel.get()

    override var canBecomeFirstResponder: Bool {
        return true
    }

    var count: Int {
        return model?.count ?? 0
    }

    var cellCount: Int {
        return count == 0 ? 1 : count + 2
    }

    func refresh() {
        model = TabsModel.get()
        collectionView.reloadData()
    }

    func actionFor(index: IndexPath) -> Action {
        if count == 0 {
            return .manageTabs
        }

        if index.row == 0 {
            return .manageTabs
        } else if index.row > count {
            return .newTab
        } else {
            return .switchToTab(atIndex: index.row - 1)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if count == 0 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "manage", for: indexPath)
        }

        if indexPath.row == 0 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "manage", for: indexPath)
        } else if indexPath.row > count {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "add", for: indexPath)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "tab", for: indexPath)
        }

    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("***", #function)
    }

}

class PopupTabSwitcherCell: UICollectionViewCell {

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print("***", #function, event as Any)
    }

}
