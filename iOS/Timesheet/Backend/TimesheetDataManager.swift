//
//  TimesheetDataManager.swift
//  Timesheet
//
//  Created by Julian Weiss on 10/1/17.
//  Copyright © 2017 Julian Weiss. All rights reserved.
//

import UIKit
import CoreData

class TimesheetDataManager: NSObject {
    let timesheetUserId:Int = 1 // in the future, this should be dynamic...
    
    /* MARK: - local
    func logsFromLocalDatabase() -> [TimesheetLog]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            debugPrint("logsFromDatabase() Unable to access application delegate")
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TimesheetLog")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            debugPrint("logsFromDatabase() Could not fetch \(error), \(error.userInfo)")
            return nil
        }
    }*/
    
    // MARK: - remote    
    func buildAddLogURL(timeIn: Date, timeOut: Date) -> URL? {
        let timeInString = formattedDate(timeIn)
        let timeOutString = formattedDate(timeOut)
        
        var url = URLComponents(string: "http://insanj.com/timesheet/api.php")
        url?.queryItems = [URLQueryItem(name: "v", value: "0.1"),
                           URLQueryItem(name: "req", value: "add"),
                           URLQueryItem(name: "user_id", value: String(timesheetUserId)),
                           URLQueryItem(name: "time_in", value: timeInString),
                           URLQueryItem(name: "time_out", value: timeOutString)]
        return url?.url
    }
    
    func buildLogsURL() -> URL? {
        var url = URLComponents(string: "http://insanj.com/timesheet/api.php")
        url?.queryItems = [URLQueryItem(name: "v", value: "0.1"),
                           URLQueryItem(name: "req", value: "history"),
                           URLQueryItem(name: "user_id", value: String(timesheetUserId))]
        return url?.url
    }
    
    typealias LogsCompletionBlock = (([TimesheetLog]?) -> Void)
    func logsFromRemoteDatabase(_ completion: @escaping LogsCompletionBlock) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let url = buildLogsURL() else {
            debugPrint("logsFromRemoteDatabase() unable to build logs URL; cannot load from remote!")
            completion(nil)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            debugPrint("logsFromRemoteDatabase() dataTask, data=\(data.debugDescription), response=\(response.debugDescription), error=\(error.debugDescription)")
            
            guard let validData = data else {
                debugPrint("logsFromRemoteDatabase() unable to parse response with invalid data response")
                completion(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: .allowFragments)
                guard let array = json as? [[AnyHashable: Any]] else {
                    debugPrint("logsFromRemoteDatabase() unable to parse response if not serialized as array")
                    completion(nil)
                    return
                }
                
                let parsed = array.flatMap {
                    TimesheetLog(json: $0)
                }
                
                completion(parsed)
            } catch {
                debugPrint("logsFromRemoteDatabase() unable to parse response using JSON serializer")
                return
            }
        }
        
        task.resume()
    }
}