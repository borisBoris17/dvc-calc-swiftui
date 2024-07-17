import SwiftUI
import SwiftData

@main
struct dvc_calc_swiftuiApp: App {
    @StateObject private var modelContainer = ModelContainerProvider()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer.container)
        }
    }
}

class ModelContainerProvider: ObservableObject {
    @Published var container: ModelContainer

    init() {
        do {
            guard let bundleURL = Bundle.main.url(forResource: "dvc", withExtension: "store") else {
                fatalError("Failed to find dvc.store in app bundle")
            }

            let fileManager = FileManager.default
            let documentDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let documentURL = documentDirectoryURL.appendingPathComponent("dvc.store")

            if !fileManager.fileExists(atPath: documentURL.path) {
                try fileManager.copyItem(at: bundleURL, to: documentURL)
            }
            
            let config = ModelConfiguration(url: documentURL)
            container = try ModelContainer(for: Resort.self, PointValue.self, Trip.self, Contract.self, VacationPoints.self, configurations: config)
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }
}
