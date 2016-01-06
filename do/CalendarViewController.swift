//
//  CalendarViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 12/8/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "January"
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected \(indexPath.row + 1)")
    }

}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CalendarCell
        cell.dateText = "\(indexPath.row + 1)"
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = CGRectGetWidth(collectionView.bounds) / CGFloat(7.0)
        return CGSize(width: width, height: width)
    }
}

