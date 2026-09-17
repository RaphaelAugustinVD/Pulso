//
//  Register.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var store: UIPreviewStore
    var onRegistered: () -> Void
    @State private var fullName = ""
    @State private var email = ""
    @State private var age = ""
    @State private var sex = "Male"
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    private let sexOptions = ["Male", "Female", "Other"]
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color.pulsoCard)
                        .frame(width: 84, height: 84)
                        .overlay(
                            Image(systemName: "heart.text.square.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.pulsoGreenDefault)
                        )
                    Text("Pulso")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    Text("Symptom tracker & relief guide")
                        .font(.subheadline)
                        .foregroundColor(.pulsoSecondaryText)
                }
                .padding(.top, 40)
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        FieldLabel(text: "Full Name")
                        PulsoTextField(placeholder: "Jane Dela Cruz",
                                       text: $fullName)
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        FieldLabel(text: "Email Address")
                        PulsoTextField(placeholder: "sample@email.com",
                                       text: $email, keyboardType: .emailAddress)
                    }
                    HStack(spacing: 12) {VStack(alignment: .leading, spacing: 6) {
                        FieldLabel(text: "Age")
                        PulsoTextField(placeholder: "21", text: $age,keyboardType: .numberPad)
                    }
                        VStack(alignment: .leading, spacing: 6) {
                            FieldLabel(text: "Sex")
                            Menu {
                                ForEach(sexOptions, id: \.self) { option in Button(option) { sex = option }
                                }
                            } label: {
                                HStack {
                                    Text(sex).foregroundColor(.white)
                                    Spacer()
                                    Image(systemName:"chevron.down").foregroundColor(.pulsoSecondaryText)
                                }
                                .padding(.vertical, 14)
                                .padding(.horizontal, 16)
                                .background(Color.pulsoCard)
                                .overlay(RoundedRectangle(cornerRadius:12).stroke(Color.pulsoBorder, lineWidth: 1)).cornerRadius(12)
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: 6) {FieldLabel(text: "Password")
                        PulsoTextField(placeholder:"**************", text: $password, isSecure: true)
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        FieldLabel(text: "Confirm Password")
                        PulsoTextField(placeholder:
                                        "**************", text: $confirmPassword, isSecure: true)
                    }
                    if let errorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    PrimaryButton(title: "Register", action: attemptRegister)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 28)
                Spacer(minLength: 40)
            }
        }
        .background(Color.pulsoBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
    private func attemptRegister() {
        guard !fullName.trimmingCharacters(in: .whitespaces).isEmpty else
        {
            errorMessage = "Please enter your full name."; return
        }
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,email.contains("@") else { errorMessage = "Please enter a valid email."; return
        }
        guard let ageValue = Int(age), ageValue > 0, ageValue < 130 else {
            errorMessage = "Please enter a valid age."; return
        }
        guard password.count >= 4 else {
            errorMessage = "Password must be at least 4 characters.";
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."; return
        }
        store.fullName = fullName
        store.email = email
        store.age = age
        store.sex = sex
        errorMessage = nil
        onRegistered()
    }
}

#Preview{
    RegisterView(onRegistered: {})
        .environmentObject(UIPreviewStore())
}
