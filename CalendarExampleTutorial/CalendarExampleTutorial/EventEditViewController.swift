//
//  EventEditViewController.swift
//  CalendarExampleTutorial
//
//  Created by Debby on 2022/08/23.
//

import UIKit

class EventEditViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.date = selectedDate
    }
    
    // MARK: - Custom Function
    @IBAction func saveAction(_ sender: Any) {
        let newEvent = Event()
        newEvent.id = eventsList.count
        newEvent.name = nameTF.text
        newEvent.date = datePicker.date
        
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
}
