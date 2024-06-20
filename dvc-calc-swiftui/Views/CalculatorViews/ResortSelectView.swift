//
//  MultiSelect.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 19/06/2024.
//

import SwiftUI

struct ResortSelectView: View {
    var resorts: [Resort]
    @Binding var selectedIndexes: [Bool]
    
    var body: some View {
        List {
            ForEach(resorts.indices) { index in
                HStack {
                    Text(resorts[index].resortName)
                    
                    Spacer()
                    
                    Toggle(isOn: $selectedIndexes[index]) {
                        
                    }
                    .toggleStyle(iOSCheckboxToggleStyle())
                    .accentColor(.primary)
                    //                        .onChange(of: selectedIndexes[index]) {
                    //                            if selectedIndexes[index] && !selectedGoals.contains(goal) {
                    //                                selectedGoals.insert(goal)
                    //                            } else if !isSelected && selectedGoals.contains(goal) {
                    //                                selectedGoals.remove(goal)
                    //                            }
                    //                        }
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
