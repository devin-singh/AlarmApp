//
//  AlarmController.swift
//  Alarm
//
//  Created by Devin Ghumman on 1/13/20.
//  Copyright © 2020 Devin Ghumman. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    var alarms: [Alarm] = []
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool){
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms[index].fireDate = fireDate
            alarms[index].name = name
            alarms[index].enabled = enabled
        }
    }
    
    func delete(alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms.remove(at: index)
        }
    }
    
    func toggleEnabled(forAlarm alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms[index].enabled = !alarms[index].enabled
        }
    }
}
