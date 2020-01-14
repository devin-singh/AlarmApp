//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Devin Ghumman on 1/13/20.
//  Copyright © 2020 Devin Ghumman. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    
    @IBOutlet weak var enableButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var alarm: Alarm?
    var alarmIsOn: Bool = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let alarm = self.alarm {
            alarmIsOn = alarm.enabled
        }
        updateViews()
    }
    
    private func updateViews() {
        if alarmIsOn {
            enableButton.setTitle("Enabled", for: .normal)
            enableButton.backgroundColor = .green
        }else{
            enableButton.setTitle("Disabled", for: .normal)
            enableButton.backgroundColor = .red
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = titleTextField.text else {return}
        if let alarm = self.alarm {
            AlarmController.sharedInstance.update(alarm: alarm, fireDate: datePicker.date, name: name, enabled: alarm.enabled)
        }else{
            AlarmController.sharedInstance.addAlarm(fireDate: datePicker.date, name: name, enabled: true)
        }
        navigationController?.popViewController(animated: true)
    }
}
