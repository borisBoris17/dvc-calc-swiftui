//
//  View+Extension.swift
//  dvc-calc-swiftui
//
//  Created by tucker bichsel on 21/08/2024.
//

import Foundation
import SwiftUI

extension View {
    func loadingView<LoadingContent: View>(
        isLoading: Bool,
        loadingContent: @escaping () -> LoadingContent
    ) -> some View {
        ZStack {
            if isLoading {
                loadingContent()
            } else {
                self
            }
        }
    }
}
