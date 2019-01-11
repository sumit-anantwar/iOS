//
//  TabSwitcher.swift
//  DuckDuckGo
//
//  Created by Christopher Brind on 11/01/2019.
//  Copyright © 2019 DuckDuckGo. All rights reserved.
//

import UIKit

class TabSwitcher: UIView {

    weak var controller: MainViewController?

}

extension TabSwitcher: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 3 : 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Tab", for: indexPath)
    }

}

extension TabSwitcher: UICollectionViewDelegate {

}

extension TabSwitcher: NibLoading { }

extension TabSwitcher {

    class func loadFromNib(into controller: MainViewController) -> TabSwitcher {
        let tabSwitcher = TabSwitcher.load(nibName: "TabSwitcher")

        tabSwitcher.becomeFirstResponder()
        tabSwitcher.autoresizingMask = []
        tabSwitcher.translatesAutoresizingMaskIntoConstraints = false

        tabSwitcher.controller = controller
        controller.view.addSubview(tabSwitcher)
        controller.view.bringSubviewToFront(tabSwitcher)

        let top = NSLayoutConstraint(item: tabSwitcher, attribute: .top,
                                     relatedBy: .equal,
                                     toItem: controller.view, attribute: .top,
                                     multiplier: 1.0,
                                     constant: 50)

        let bottom = NSLayoutConstraint(item: tabSwitcher, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: controller.view, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: -65)

        let trailing = NSLayoutConstraint(item: tabSwitcher, attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: controller.view, attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: -25)

        let width = NSLayoutConstraint(item: tabSwitcher, attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil, attribute: .notAnAttribute,
                                       multiplier: 1.0,
                                       constant: 250)

        controller.view.addConstraint(top)
        controller.view.addConstraint(bottom)
        controller.view.addConstraint(trailing)
        controller.view.addConstraint(width)

        return tabSwitcher
    }

}
