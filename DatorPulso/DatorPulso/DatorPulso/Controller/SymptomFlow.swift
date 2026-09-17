//
//  SymptomFlow.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
struct SymptomFlowView: View {
    let date: Date
    var onFinish: () -> Void
    @State private var path = NavigationPath()
    @State private var selectedSymptoms: Set<String> = []
    @State private var temperature: String = ""
    var body: some View {
        NavigationStack(path: $path) {
            SymptomLoggingView(
                date: date,
                selectedSymptoms: $selectedSymptoms,
                temperature: $temperature,
                onSubmit: { path.append("match") }
            )
            .navigationDestination(for: String.self) { _ in
                PossibleMatchView(
                    date: date,
                    symptoms: Array(selectedSymptoms),
                    temperature: temperature,
                    onFinish: onFinish
                )
            }
        }
    }
}

#Preview {
    SymptomFlowView(date: Date(), onFinish: {})
        .environmentObject(UIPreviewStore())
}
