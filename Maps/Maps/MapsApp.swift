//
//  MapsApp.swift
//  Maps
//
//  Created by Liliia Makashova on 2022-04-13.
//

import SwiftUI
import PartialSheet

@main
struct MapsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView  {
                ContentView()
            }.attachPartialSheetToRoot()
        }
    }
}





