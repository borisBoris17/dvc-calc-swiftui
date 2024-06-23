//
//  MultiSelect.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 19/06/2024.
//

import SwiftUI

struct ResortSelectView: View {
    @Binding var resorts: [Resort : Bool]
    @State private var selectAll = false
    
    func isAllResortsSelected() -> Bool {
        let selectedResorts = resorts.filter { $0.value == true }
        return resorts.count == selectedResorts.count
    }
    
    var body: some View {
        List {
            HStack {
                Text(isAllResortsSelected() ? "Deselect All" : "Select All")
                
                Spacer()
                
                Toggle(isOn: $selectAll) {
                    // Empty label
                }
                .toggleStyle(iOSCheckboxToggleStyle())
                .accentColor(.primary)
                .onChange(of: selectAll) {
                    if isAllResortsSelected() {
                        for (key, _) in resorts {
                            resorts[key] = false
                        }
                    } else {
                        for (key, _) in resorts {
                            resorts[key] = true
                        }
                    }
                }
            }
            
            ForEach(resorts.sorted(by: { $0.key.resortName < $1.key.resortName }), id: \.key) { key, value in
                HStack {
                    Text(key.resortName)
                    
                    Spacer()
                    
                    Toggle(isOn: Binding(
                        get: { resorts[key] ?? false },
                        set: { newValue in
                            resorts[key] = newValue
                        }
                    )) {
                        // Empty label
                    }
                    .toggleStyle(iOSCheckboxToggleStyle())
                    .accentColor(.primary)
                }
            }
        }
        .onAppear() {
            if isAllResortsSelected() {
                selectAll = true
            }
        }
        .navigationTitle("Resorts")
    }
    
    struct iOSCheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            Button(action: {
                configuration.isOn.toggle()
            }, label: {
                HStack {
                    Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    configuration.label
                }
            })
        }
    }
}

//#Preview {
//    ResortSelectView()
//}
