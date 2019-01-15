//
//  PopupTabSwitcherViewController.swift
//  DuckDuckGo
//
//  Created by Christopher Brind on 13/01/2019.
//  Copyright © 2019 DuckDuckGo. All rights reserved.
//

import UIKit

protocol PopupTabSwitcherDelegate {

    func newTab()
    func switchToTab(atIndex: Int)
    func manageTabs()

}

class PopupTabSwitcherViewController: UICollectionViewController {

    enum Action {

        case newTab
        case switchToTab(atIndex: Int)
        case manageTabs

    }

    var delegate: PopupTabSwitcherDelegate?

    var selectedIndex: IndexPath?

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

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = false
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
            return updateSelected(collectionView.dequeueReusableCell(withReuseIdentifier: "manage", for: indexPath), indexPath == selectedIndex)
        }

        if indexPath.row == 0 {
            return updateSelected(collectionView.dequeueReusableCell(withReuseIdentifier: "manage", for: indexPath), indexPath == selectedIndex)
        } else if indexPath.row > count {
            return updateSelected(collectionView.dequeueReusableCell(withReuseIdentifier: "add", for: indexPath), indexPath == selectedIndex)
        } else {
            let cell = updateSelected(collectionView.dequeueReusableCell(withReuseIdentifier: "tab", for: indexPath), indexPath == selectedIndex)
            cell.label.text = model?.tabs[indexPath.row - 1].link?.title
            return cell
        }

    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("***", #function)

        if indexPath.row == 0 {
            delegate?.manageTabs()
        } else if indexPath.row > count {
            delegate?.newTab()
        } else {
            delegate?.switchToTab(atIndex: indexPath.row - 1)
        }

    }

    func hoverOver(indexPath: IndexPath) {
        var indexes = [ indexPath ]
        if let previousIndex = selectedIndex {
            indexes.append(previousIndex)
        }
        collectionView.reloadItems(at: indexes)
        selectedIndex = indexPath
    }

    private func updateSelected(_ cell: UICollectionViewCell, _ selected: Bool) -> PopupTabSwitcherCell {
        guard let cell = cell as? PopupTabSwitcherCell else {
            fatalError("unable to cast PopupTabSwitcherCell")
        }

        cell.isSelected = selected
        return cell
    }

}

class PopupTabSwitcherCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!

    override var isSelected: Bool {
        didSet {
            // print(#function, isSelected, oldValue)
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = isSelected ? 2.0 : 0.0
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print("***", #function, event as Any)
    }

}
