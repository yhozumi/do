//
//  CalendarViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 12/8/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    private var collectionCellSize: CGSize?
    
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
        print("cell width from cellForRowAtIndexPath \(cell.bounds.width)")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Weekdays", forIndexPath: indexPath) as! CalendarHeaderView
            header.delegate = self
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = CGRectGetWidth(collectionView.bounds) / CGFloat(7.0)
        collectionCellSize = CGSize(width: width, height: width)
        return collectionCellSize!
    }
}

extension CalendarViewController: CalendarHeaderViewDelegate {
    var cellSize: CGSize { return collectionCellSize! }
    var centerX: CGFloat { return 10  }
}
