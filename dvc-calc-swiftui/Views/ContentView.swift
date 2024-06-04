//
//  ContentView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 16/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            CalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "plus.forwardslash.minus")
                }
                .tag(1)
            
            TripsView()
                .tabItem {
                    Label("Trips", systemImage: "calendar")
                }
                .tag(2)
            
            ContractsView()
                .tabItem {
                    Label("Contracts", systemImage: "doc.plaintext")
                }
                .tag(2)
        }
//        .background(Color("BackgroundColor"))
    }
}

#Preview {
    ContentView()
}
