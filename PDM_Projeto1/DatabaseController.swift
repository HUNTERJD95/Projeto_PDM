//
//  datacontroller.swift
//  PDM_Projeto1
//
//  Created by Emu Wu on 18/07/2023.
//

import SQLite
import Foundation

class DatabaseController {
    static let instance = DatabaseController()
    var db: Connection?
    
    private init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            db = try Connection("\(path)/db.sqlite3")
        } catch {
            print("Cannot connect to database: \(error)")
        }
    }
    
    func createTablesIfNotExists() {
        do {
            let users = Table("users")
            let id = Expression<Int64>("id")
            let username = Expression<String>("username")
            let password = Expression<String>("password")

            try db?.run(users.create(ifNotExists: true) { t in
                    t.column(id, primaryKey: true)
                    t.column(username, unique: true)
                    t.column(password)
            })
            
            // TODO add more tables
        }
        catch {
            print("Cannot connect table: \(error)")
        }
    }
    
    func checkIfTablesAreCreated() -> Bool {
        do {
            let query = "SELECT name FROM sqlite_master WHERE type = 'table' and name = 'users'"
            let statement = try db?.prepare(query)
            if let _ = statement?.next() {
                return true
            }
        } catch {
            print("Cannot verify if table exists: \(error)")
        }
        return false
    }
}
