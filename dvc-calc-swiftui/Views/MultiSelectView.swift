//
//  MultiSelectView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 22/06/2024.
//

import SwiftUI

struct MultiSelectView<T: HashableDisplayable>: View {
    @Binding var options: [T : Bool]
    @State private var selectAll = false
    var title: String
    
    func isAllOptionsSelected() -> Bool {
        let selectedOptions = options.filter { $0.value == true }
        return options.count == selectedOptions.count
    }
    
    var body: some View {
        List {
            HStack {                
                Button {
                    selectAll.toggle()
                } label: {
                    HStack {
                        Text(isAllOptionsSelected() ? "Deselect All" : "Select All")
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: isAllOptionsSelected() ? "checkmark.square" : "square")
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                .onChange(of: selectAll) {
                    if isAllOptionsSelected() {
                        for (key, _) in options {
                            options[key] = false
                        }
                    } else {
                        for (key, _) in options {
                            options[key] = true
                        }
                    }
                }
            }
            
            ForEach(options.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                HStack {
                    Text(key.display())
                    
                    Spacer()
                    
                    Toggle(isOn: Binding(
                        get: { options[key] ?? false },
                        set: { newValue in
                            options[key] = newValue
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
            if isAllOptionsSelected() {
                selectAll = true
            }
        }
        .navigationTitle(title)
    }
}

//
//#Preview {
//    MultiSelectView()
//}
