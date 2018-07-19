//
//  EventModel.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import Foundation

class EventModel: CustomStringConvertible {
    private var data: [Event]
    private var nextDate: Date
    
    /// Async Delegate
    var asyncDelegate: AsyncDelegate?
    
    //MARK: - Subscript
    subscript(index: Int) -> Event {
        if index > count - 10 {
            fetchEvents()
        }
        return data[index]
    }
    
    var count: Int {
        return data.count
    }
    
    init() {
        nextDate = Date()
        data = [Event]()
        
        fetchEvents()
    }
    
    /// Fetch events from the nextDate to the subsequent month
    private func fetchEvents() {
        let endDate = Calendar.current.date(byAdding: .month, value: 1, to: nextDate)!
        
        print("Fetching events from: \(nextDate) to: \(endDate)")
        APIClient.events(startDate: nextDate, endDate: endDate) { [unowned self] result in
            switch result {
            case .success(let events):
                self.data.append(contentsOf: events)
                self.asyncDelegate?.asyncUpdate(response: AsyncResponse.success)
            case .failure(let error):
                print(error.localizedDescription)
                self.asyncDelegate?.asyncUpdate(response: AsyncResponse.failure(description: error.localizedDescription))
            }
        }
        
        nextDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)!
    }
    
    //MARK: - CustomStringConvertible
    var description: String {
        var description = "\(data.count) Events"
        if data.count > 0 {
            description = "\(description)\nFirst: \(data[0])\nLast: \(data[data.count - 1])"
        }
        
        return description
    }
}
