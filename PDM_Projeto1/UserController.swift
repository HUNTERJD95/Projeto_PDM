//
//  UserController.swift
//  PDM_Projeto1
//
//  Created by Emu Wu on 20/07/2023.
//
import SQLite3
import Foundation

class UserControllerHolder: ObservableObject {
    @Published var userController = UserController()

    // Add any other shared data or methods here, if needed
}

struct User {
    let id: Int64
    let username: String
    let password: String
}

class UserController {
    private var db: OpaquePointer?

      private var fileURL: URL? {
          guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
              return nil
          }
          return documentDirectoryURL.appendingPathComponent("db.sqlite3") //Verify DB name!!
      }

      init() {
          // Open the database connection
          if let fileURL = fileURL?.absoluteString {
              if sqlite3_open(fileURL, &db) != SQLITE_OK {
                  print("Error opening database.")
              }
          } else {
              print("Error finding database file URL.")
          }
          createTableIfNotExists()
      }

    deinit {
        // Close the database connection when the UserController is deallocated
        if sqlite3_close(db) != SQLITE_OK {
            print("Error closing database.")
        }
    }

    private func createTableIfNotExists() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL UNIQUE,
                password TEXT NOT NULL
            );
        """

        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Error creating table.")
        }
    }
    
    
    func createUser(username: String, password: String) -> Bool {
           let createTableQuery = """
               INSERT INTO users (username, password)
               VALUES (?, ?);
           """

           var statement: OpaquePointer?

           if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
               sqlite3_bind_text(statement, 1, (username as NSString).utf8String, -1, nil)
               sqlite3_bind_text(statement, 2, (password as NSString).utf8String, -1, nil)

               if sqlite3_step(statement) == SQLITE_DONE {
                   // User created successfully
                   return true
               } else {
                   // Error occurred while creating user
                   print("Error creating user: \(String(cString: sqlite3_errmsg(db)))")
               }
           } else {
               // Error in query preparation
               print("Error preparing createUser query: \(String(cString: sqlite3_errmsg(db)))")
           }

           // Release the statement
           sqlite3_finalize(statement)

           return false
       }

    
    
    func getUser(username: String, password: String) -> User? {
            let query = "SELECT * FROM users WHERE username = ? AND password = ?;"
            var statement: OpaquePointer?
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, (username as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 2, (password as NSString).utf8String, -1, nil)

                if sqlite3_step(statement) == SQLITE_ROW {
                    let id = sqlite3_column_int64(statement, 0)
                    let resultUsername = String(cString: sqlite3_column_text(statement, 1))
                    let resultPassword = String(cString: sqlite3_column_text(statement, 2))

                    sqlite3_finalize(statement)
                    return User(id: id, username: resultUsername, password: resultPassword)
                }
           }

           sqlite3_finalize(statement)
           return nil
       }
    
    func updateUser(id: Int64, newUsername: String, newPassword: String) -> Bool {
           let updateQuery = "UPDATE users SET username = ?, password = ? WHERE id = ?;"

           var statement: OpaquePointer?
           if sqlite3_prepare_v2(db, updateQuery, -1, &statement, nil) == SQLITE_OK {
               sqlite3_bind_text(statement, 1, (newUsername as NSString).utf8String, -1, nil)
               sqlite3_bind_text(statement, 2, (newPassword as NSString).utf8String, -1, nil)
               sqlite3_bind_int64(statement, 3, id)

               if sqlite3_step(statement) == SQLITE_DONE {
                   sqlite3_finalize(statement)
                   return true
               }
           }

           sqlite3_finalize(statement)
           return false
       }

       func deleteUser(id: Int64) -> Bool {
           let deleteQuery = "DELETE FROM users WHERE id = ?;"

           var statement: OpaquePointer?
           if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
               sqlite3_bind_int64(statement, 1, id)

               if sqlite3_step(statement) == SQLITE_DONE {
                   sqlite3_finalize(statement)
                   return true
               }
           }

           sqlite3_finalize(statement)
           return false
       }
}
