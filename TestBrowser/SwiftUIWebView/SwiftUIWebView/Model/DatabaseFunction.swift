//
//  Databasefunction.swift
//  SwiftUIWebView
//
//  Created by Daniel on 12/8/21.
//  Copyright © 2021 Md. Yamin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public class DatabaseFunctions
{
    let ref = Database.database().reference()
    var date: Date = Date()
    //var databaseHandle = databaseHandle()?
    
    public func createTimestamp() -> String
    {
        self.date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        let dateString = dateFormatter.string(from: self.date)
        return dateString
        
    }
    public func writeToDataBase(key: String, dictionary: NSDictionary)
    {
        //write to the database
        self.ref.child(key).setValue(dictionary)
    }
    
    public func readFromDatabase()
    {
        //connect
        self.ref.observeSingleEvent(of: .value, with: {snapshot in
            if !snapshot.exists(){return}
            print(snapshot.value!)
        })
    }
    public func getHomepage(completion: @escaping(String)->())
    {
        databaseHandle = ref.child("homepage").observe(.childAdded, with:{
            (snapshot) in
            let value = snapshot.value as! String
            completion(value)
        })
    }
}
