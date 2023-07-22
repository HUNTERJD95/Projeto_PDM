//
//  PDM_Projeto1App.swift
//  PDM_Projeto1
//
//  Created by user239318 on 6/1/23.
//
import CoreData
import SwiftUI

@main
struct PDM_Projeto1App: App {
    init() {
        DatabaseController.instance.createTablesIfNotExists()
        
        if DatabaseController.instance.checkIfTablesAreCreated() {
            print("Table users exists")
        } else {
            print("Table users does not exist")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
