//
//  MultiSelect.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 19/06/2024.
//

import SwiftUI

struct ResortSelectView: View {
    @Binding var resorts: [Resort : Bool]
    
    var body: some View {
        List {
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
