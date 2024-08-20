//
//  MultiSelectInGroupsView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 19/08/2024.
//

import SwiftUI
import SwiftData

struct MultiSelectInGroupsView<T: HashableDisplayable, U: HashableDisplayable>: View {
    @Binding var options: [U : [T : Bool]]
    @State private var selectAll = false
    var title: String
    
    @Query var resorts: [Resort]
    
    func isAllOptionsSelected() -> Bool {
        var allSelectedOptions = 0
        var allOptions = 0
        for item in options {
            allOptions += item.value.count
            allSelectedOptions += item.value.filter { $0.value == true }.count
        }
        return allOptions == allSelectedOptions
    }
    
    var body: some View {
        List {
            HStack {
                Button {
                    selectAll.toggle()
                } label: {
                    HStack {
                        Text(isAllOptionsSelected() ? "Deselect All" : "Select All")
                            .foregroundStyle(Color.constantFont)
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: isAllOptionsSelected() ? "checkmark.square" : "square")
                                .foregroundStyle(Color.constantFont)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                .onChange(of: selectAll) {
                    if isAllOptionsSelected() {
                        for (key1, value) in options {
                            for (key2, _) in value {
                                options[key1]?[key2] = false
                            }
                        }
                    } else {
                        for (key1, value) in options {
                            for (key2, _) in value {
                                options[key1]?[key2] = true
                            }
                        }
                    }
                }
            }
            .listRowBackground(Color.secondaryBackground)
            
            ForEach(options.sorted(by: { $0.key < $1.key }), id: \.key) { key1, _ in
                HStack {
                    Spacer()
                    
                    Text(key1.display())
                        .foregroundStyle(Color.constantFont)
                        .fontWeight(.bold)
                }
                .listRowBackground(Color.secondaryBackground)
                
                ForEach(options[key1]?.sorted(by: { $0.key < $1.key }) ?? [], id: \.key) { key2, value in
                    
                    HStack {
                        Text(key2.display())
                            .foregroundStyle(Color.constantFont)
                        
                        Spacer()
                        
                        Toggle(isOn: Binding(
                            get: { options[key1]?[key2] ?? false },
                            set: { newValue in
                                options[key1]?[key2] = newValue
                            }
                        )) {
                            // Empty label
                        }
                        .toggleStyle(iOSCheckboxToggleStyle())
                        .accentColor(Color.constantFont)
                    }
                    .listRowBackground(Color.secondaryBackground)
                }
            }
        }
        .onAppear() {
            if title == "Resorts" && options.count == 0 {
                for resort in resorts {
                    for (key, _) in options {
                        options[key]?[resort as! T] = true
                    }
                }
            }
            if isAllOptionsSelected() {
                selectAll = true
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.background)
        //        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    //    MultiSelectInGroupsView()
}
