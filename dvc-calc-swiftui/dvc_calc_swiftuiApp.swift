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
            guard let bundleURL = Bundle.main.url(forResource: "dvc", withExtension: "store") else {
                fatalError("Failed to find default.store in app bundle")
            }
            
            let fileManager = FileManager.default
            let documentDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let documentURL = documentDirectoryURL.appendingPathComponent("default.store")
            
            // Only copy the store from the bundle to the Documents directory if it doesn't exist
            if !fileManager.fileExists(atPath: documentURL.path) {
                try fileManager.copyItem(at: bundleURL, to: documentURL)
            }
            
            let config = ModelConfiguration(url: documentURL)
            container = try ModelContainer(for: Resort.self, PointValue.self, configurations: config)
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }
}
