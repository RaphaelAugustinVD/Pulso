//
//  LoginView.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct LoginView: View {
    var onRegisterTap: () -> Void
    var onLoggedIn: () -> Void
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 22).fill(Color.pulsoCard).frame(width: 84, height: 84)
                        .overlay(
                            Image(systemName: "heart.text.square.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.pulsoGreenDefault))
                    Text("Pulso")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    Text("Symptom tracker & relief guide")
                        .font(.subheadline)
                        .foregroundColor(.pulsoSecondaryText)
                }
                .padding(.top, 60)
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        FieldLabel(text: "Email Address")
                        PulsoTextField(placeholder: "sample@email.com",
                                       text: $email, keyboardType: .emailAddress)
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        FieldLabel(text: "Password")
                        PulsoTextField(placeholder:
                                        "**************", text: $password, isSecure: true)
                    }
                    if let errorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    PrimaryButton(title: "Log In", action: attemptLogin).padding(.top, 8)
                    Text("or")
                        .font(.footnote)
                        .foregroundColor(.pulsoSecondaryText)
                        .frame(maxWidth: .infinity, alignment: .center)
                    SecondaryButton(title: "Register", action:onRegisterTap)
                }
                .padding(.horizontal, 28)
                Spacer(minLength: 40)
            }
        }
        .background(Color.pulsoBackground.ignoresSafeArea())
        .navigationBarHidden(true)
    }
    private func attemptLogin() {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,!password.isEmpty else {
            errorMessage = "Please enter your email and password."
            return
        }
        errorMessage = nil
        onLoggedIn()
    }
}

#Preview {
    LoginView(onRegisterTap: {}, onLoggedIn: {})
}
