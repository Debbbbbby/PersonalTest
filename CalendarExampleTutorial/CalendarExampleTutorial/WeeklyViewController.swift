//
//  WeeklyViewController.swift
//  CalendarExampleTutorial
//
//  Created by Debby on 2022/08/22.
//  Lecture : https://www.youtube.com/watch?v=E-bFeJLsvW0&t=52s

/*
 MARK: - UIColors Memo
 UIColor(hue: 0.1278, saturation: 0.69, brightness: 0.95, alpha: 1.0) /* #f4cf4b */ - 노란색
 UIColor(hue: 0.7167, saturation: 0.41, brightness: 0.51, alpha: 1.0) /* #5e4d84 */ - 연한 보라색
 UIColor(hue: 0.6917, saturation: 0.5, brightness: 0.25, alpha: 1.0) /* #262142 */ - 기본 보라색
 UIColor(hue: 0.6889, saturation: 0.58, brightness: 0.18, alpha: 1.0) /* #17132e */ - 진한 보라색
 */

import UIKit

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date() // 선택한 날짜, 디폴트 : 오늘
    var totalSquares = [Date]() // 날짜를 기준으로 표시
    
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
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if (date == selectedDate) {
            cell.layer.cornerRadius = 6.0
            cell.layer.borderWidth = 2.5
            cell.layer.borderColor = UIColor.systemIndigo.cgColor
        } else {
            cell.layer.borderColor = UIColor.clear.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
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
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday) {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
        yearLabel.text = CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    // MARK: - @IBAction
    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setMonthView()
    }
       
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setMonthView()
    }
    override var shouldAutorotate: Bool {
        return false
    }
}

