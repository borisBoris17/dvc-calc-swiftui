//
//  ContentView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 16/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    @State private var calculatorPath = NavigationPath()
    //    @State private var activitiesPath = NavigationPath()
    //    @State private var peoplePath = NavigationPath()
    
    private func tabSelection() -> Binding<Int> {
        Binding {
            self.selection
        } set: { tappedTab in
            if tappedTab == self.selection {
                if tappedTab == 1 {
                    calculatorPath = NavigationPath()
                } else if tappedTab == 2 {
                    //                 activitiesPath = NavigationPath()
                } else {
                    //                 peoplePath = NavigationPath()
                }
            }
            self.selection = tappedTab
        }
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CalculatorView(path: $calculatorPath)
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
