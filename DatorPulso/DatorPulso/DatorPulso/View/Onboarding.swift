//
//  Onboarding.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct OnboardingView: View {
    var onComplete: () -> Void
    @State private var isPressing = false
    @State private var pulseScale: CGFloat = 1.0
    @State private var didComplete = false
    private let holdDuration: Double = 1.1
    var body: some View {
        ZStack {
            Color.pulsoBackground.ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    Circle().fill(Color.green.opacity(isPressing ? 0.30 :0.0))
                        .frame(width: 240, height: 240)
                        .scaleEffect(pulseScale)
                        .animation(isPressing
                                   ?.easeInOut(duration:0.55).repeatForever(autoreverses: true)
                                   : .easeOut(duration: 0.3),
                                   value: pulseScale
                        )
                    RoundedRectangle(cornerRadius: 26)
                        .fill(Color.pulsoCard)
                        .frame(width: 96, height: 96)
                        .overlay(Image(systemName: "heart.text.square.fill")
                            .font(.system(size: 42))
                            .foregroundColor(.green))
                }
                Text("Pulso")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                Text("Symptom tracker & relief guide")
                    .font(.subheadline)
                    .foregroundColor(.pulsoSecondaryText)
                Spacer()
                Text(isPressing ? "Keep holding!" : "Press and hold to begin")
                    .font(.footnote)
                    .foregroundColor(.pulsoSecondaryText)
                    .padding(.bottom, 50)
            }
        }
        .contentShape(Rectangle()).gesture(
            DragGesture(minimumDistance: 0).onChanged { _ in beginPress() }.onEnded { _ in endPress() })
    }
    private func beginPress() {
        guard !isPressing, !didComplete else { return }
        isPressing = true
        pulseScale = 1.3
        DispatchQueue.main.asyncAfter(deadline: .now() + holdDuration) {
            if isPressing { complete() }
        }
    }
    private func endPress() {
        guard !didComplete else { return }
        isPressing = false
        pulseScale = 1.0
    }
    private func complete() {didComplete = true
        isPressing = false
        withAnimation(.easeOut(duration: 0.4)) {
            pulseScale = 1.8
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {onComplete()
        }
    }
}


#Preview{
    OnboardingView(onComplete: {})
}
