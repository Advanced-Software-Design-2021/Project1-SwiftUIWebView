//
//  DataBaseFunctions.swift
//  SwiftUIWebView
//
//  Created by Varnith Nookala on 12/8/21.
//  Copyright © 2021 Md. Yamin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public class DatabaseFunctions
{
    let ref = Database.database().reference()
    var date: Date = Date()
    
    
    
    public func createTimestamp() -> String
    {
        //initialize and format date
        self.date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        let dateString = dataFormatter.string(from: self.date)
        
        return dateString
    }
    
    public func writeToDataBase(key: String, dictionary: NSDictionary)
    {
        //Write to the database
        self.ref.child(key).setValue(dictionary)
    }
    
    public func readFromDatabase()
    {
        //Connect to database
        self.ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot.value!)
            
        })
    }
    
    public func getHomepage(completion: @escaping (String) -> ())
    {
        databaseHandle = ref.child("homepage").observe(.childAdded, with:
            { (snapshot) in
            
            let value = snapshot.value as! String
            
            completion(value)
            
            })
    }
}


