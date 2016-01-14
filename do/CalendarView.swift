//
//  CalendarView.swift
//  do
//
//  Created by Yusuke Hozumi on 1/14/16.
//  Copyright © 2016 Yusuke Hozumi. All rights reserved.
//

import UIKit

protocol CalendarViewDataSource {
    func startDate() -> NSDate?
    func endDate() -> NSDate?
}

protocol CalendarViewDelegate {
    func calendarView(calendar: CalendarView, didScrollToMonth: NSDate)
    func calendarView(calendar: CalendarView, didSelectDate: NSDate)
}

class CalendarView: UIView {
    
    var delegate: CalendarViewDelegate?
    var dataSource: CalendarViewDataSource?
    
    private var startDate = NSDate()
    private var endDate = NSDate()
    private var startMonth = NSDate()
    private var todaysDate = NSDate()
    
    private(set) var selectedIndexPaths = [NSIndexPath]()
    private(set) var selectedDates = [NSDate]()
    
    lazy var calendarView: UICollectionView = {
        let layout = CalendarFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        
        let calendar = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.pagingEnabled = true
        calendar.backgroundColor = UIColor.clearColor()
        calendar.showsHorizontalScrollIndicator = false
        calendar.showsVerticalScrollIndicator = false
        calendar.allowsMultipleSelection = true
        return calendar
    }()
    
    lazy var calendarHeaderView: CalendarHeaderView = {
        let header = CalendarHeaderView()
        return header
    }()
    
    override var frame: CGRect {
        didSet {
        
        }
    }
}

extension CalendarView: UICollectionViewDelegate {
    
}

extension CalendarView: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let layout = collectionView.collectionViewLayout as! CalendarFlowLayout
        layout.itemSize = CGSizeMake(self.calendarView.frame.size.width / 7.0, self.calendarView.frame.height - layout.headerReferenceSize.height / 6.0) //7 is maximum number of weeks and 6.0 is maximum row in calendar view
        self.calendarView.collectionViewLayout = layout
        guard let startDate = self.dataSource?.startDate() else { return 0 }
        guard let endDate = self.dataSource?.endDate() else { return 0 }
        self.startDate = startDate
        self.endDate = endDate
        
        if NSCalendar.currentCalendar().compareDate(startDate, toDate: endDate, toUnitGranularity: NSCalendarUnit.Nanosecond) != NSComparisonResult.OrderedAscending {
            return 0
        }
        
        
        
        
    }
}
