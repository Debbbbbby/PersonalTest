//
//  ViewController.swift
//  CalendarExampleTutorial
//
//  Created by Debby on 2022/08/18.
//  Lecture : https://www.youtube.com/watch?v=abbWOYFZd68

/*
 MARK: - UIColors Memo
 UIColor(hue: 0.1278, saturation: 0.69, brightness: 0.95, alpha: 1.0) /* #f4cf4b */ - 노란색
 UIColor(hue: 0.7167, saturation: 0.41, brightness: 0.51, alpha: 1.0) /* #5e4d84 */ - 연한 보라색
 UIColor(hue: 0.6917, saturation: 0.5, brightness: 0.25, alpha: 1.0) /* #262142 */ - 기본 보라색
 UIColor(hue: 0.6889, saturation: 0.58, brightness: 0.18, alpha: 1.0) /* #17132e */ - 진한 보라색
 */

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var totalSquares = [String]()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    }
    
    // MARK: - CollectionView Setting
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }
    
    // MARK: - Custom Functions
    func setCellsView() { // -2 : padding, / 8은 셀이 7이 될 경우 한 칸 내려줄 셀을 구분하기 위해서
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        var count: Int = 1
        while (count <= 42) {
            if (count <= startingSpaces || count - startingSpaces > daysInMonth) {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces)) // blank 처리 되어야 하는 셀
            }
            count += 1
        }
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
        yearLabel.text = CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    // MARK: - @IBAction
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    override var shouldAutorotate: Bool {
        return false
    }
}

