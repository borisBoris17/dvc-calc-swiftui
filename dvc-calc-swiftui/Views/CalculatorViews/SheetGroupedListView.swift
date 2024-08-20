//
//  SheetGroupedListView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 19/08/2024.
//

import SwiftUI

struct SheetGroupedListView: View {
    @Binding var options: [ResortArea : [Resort : Bool]]
    var title: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            MultiSelectInGroupsView(options: $options, title: title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem {
                        Button("Dismiss") {
                            dismiss()
                        }
                    }
                }
        }
    }
}
