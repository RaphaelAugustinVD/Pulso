//
//  RootView.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
struct RootView: View {
    @State private var showOnboarding = true
    @State private var isLoggedIn = false
    var body: some View {
        Group {
            if showOnboarding {
                OnboardingView {
                    withAnimation { showOnboarding = false }
                }
            } else if isLoggedIn {
                DashboardView(onLogout: { isLoggedIn = false })
            } else {
                AuthFlowView(onLoggedIn: { isLoggedIn = true })
            }
        }
    }
}

struct AuthFlowView: View {
    var onLoggedIn: () -> Void
    @State private var showRegister = false
    var body: some View {
        NavigationStack {
            LoginView(
                onRegisterTap: { showRegister = true },
                onLoggedIn: onLoggedIn
            )
            .navigationDestination(isPresented: $showRegister) {
                RegisterView(onRegistered: onLoggedIn)
            }
        }
    }
}

#Preview{
    RootView()
        .environmentObject(UIPreviewStore())
}
