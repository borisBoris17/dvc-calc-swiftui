//
//  dvc_calc_swiftuiApp.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 16/05/2024.
//

import SwiftUI
import SwiftData

@main
struct dvc_calc_swiftuiApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            guard let storeURL = Bundle.main.url(forResource: "dvc", withExtension: "store") else {
                fatalError("Failed to find dvc.store")
            }
            
            let config = ModelConfiguration(url: storeURL)
            container = try ModelContainer(for: Resort.self, PointValue.self, configurations: config)
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }
}
