//
//  DBManager.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 02/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit
import FMDB

class DBManager: NSObject {

    static let shared: DBManager = DBManager()
    
    let databaseFileName = "hkdict.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    override init() {
        super.init()
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent(databaseFileName)
            let documentsUrl = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)
            let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(databaseFileName)
            do {
                try FileManager.default.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
            database = FMDatabase(path: pathToDatabase!)
            if database != nil {
                // Open the database.
                if database.open() {
                    created = true
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func executeUpdate(query: String) {
        do {
            try database.executeUpdate(query, values: nil)
        } catch {
            
        }
    }
}
