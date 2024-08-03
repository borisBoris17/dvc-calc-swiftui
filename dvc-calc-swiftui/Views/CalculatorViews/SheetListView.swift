//
//  SheetListView.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 02/08/2024.
//

import SwiftUI

struct SheetListView<T: HashableDisplayable>: View {
    @Binding var options: [T : Bool]
    var title: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            MultiSelectView(options: $options, title: title)
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
