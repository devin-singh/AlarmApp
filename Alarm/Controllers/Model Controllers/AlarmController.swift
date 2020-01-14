//
//  AlarmController.swift
//  Alarm
//
//  Created by Devin Singh on 1/13/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications(forAlarm alarm: Alarm)
    func cancelUserNotifications(forAlarm alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(forAlarm alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm \(alarm.name) went off"
        content.body = "Your \(alarm.fireTimeAsString) alarm has went off"
        content.sound = UNNotificationSound.default
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Failed to request \(error)")
            }
        }
    }
    
    func cancelUserNotifications(forAlarm alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}

class AlarmController: AlarmScheduler {
    
    static let sharedInstance = AlarmController()
    
    var alarms: [Alarm] = []
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool){
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
        saveToPersistantStore()
        scheduleUserNotifications(forAlarm: newAlarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms[index].fireDate = fireDate
            alarms[index].name = name
            alarms[index].enabled = enabled
            saveToPersistantStore()
        }
    }
    
    func delete(alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            cancelUserNotifications(forAlarm: alarms[index])
            alarms.remove(at: index)
            saveToPersistantStore()
        }
    }
    
    func toggleEnabled(forAlarm alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            if alarms[index].enabled == false {
                alarms[index].enabled = true
                scheduleUserNotifications(forAlarm: alarms[index])
            } else {
                alarms[index].enabled = false
                cancelUserNotifications(forAlarm: alarms[index])
            }
            saveToPersistantStore()
        }
    }
    
     // MARK: - Persistence
    
    func createFileForPersistence() -> URL {
        // Grab the users Document directory
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // Create the new fileURL on the users Phone
         let fileUrl = urls[0].appendingPathComponent("Alarms.json")
         return fileUrl
     }
    
    func saveToPersistantStore() {
        // Create an instance of JSONEncoder
        let jsonEncoder = JSONEncoder()
        // Attempt to convert our playlist array into JSON
        // Anytime a method throws, it must be placed in a do, try, catch block
        do {
            let jsonAlarms = try jsonEncoder.encode(alarms)
            // With the new JSON(d) playlist arraay, save it to the users device
            try jsonAlarms.write(to: createFileForPersistence())
        } catch let encodingError {
            print("There was an error saving the data! \(encodingError)")
        }
    }
    
    func loadFromPersistentStorage() {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: createFileForPersistence())
            let decodedPlaylists = try jsonDecoder.decode([Alarm].self, from: jsonData)
            alarms = decodedPlaylists
        } catch let decodingError {
            print("Error loading data \(decodingError)")
        }
    }
}
