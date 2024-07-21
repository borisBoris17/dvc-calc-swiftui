import SwiftUI
import SwiftData

@main
struct dvc_calc_swiftuiApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Resort.self, PointValue.self, Trip.self, Contract.self, VacationPoints.self]) { result in
                    do {
                        let container = try result.get()
                        
                        // Check we haven't already added our users.
                        let descriptor = FetchDescriptor<Resort>()
                        let existingUsers = try container.mainContext.fetchCount(descriptor)
                        guard existingUsers == 0 else {print(existingUsers); return }
                        
                        // Load and decode the JSON.
                        guard let url = Bundle.main.url(forResource: "dvc", withExtension: "json") else {
                            fatalError("Failed to find dvc.json")
                        }
                        
                        let data = try Data(contentsOf: url)
                        let resorts = try JSONDecoder().decode([Resort].self, from: data)
                        
                        // Add all our data to the context.
                        for resort in resorts {
                            container.mainContext.insert(resort)
                        }
                        
                        try container.mainContext.save()
                    } catch {
                        print("Failed to pre-seed database. \(error)")
                    }
                }
        }
        
    }
}
