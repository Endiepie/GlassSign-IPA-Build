//
//  GlassSignWelcomeCard.swift
//  GlassSign
//
//  A Liquid Glass welcome surface for the first IPA import.
//  Derived from Feather (GPL-3.0); see the repository LICENSE.
//

import SwiftUI

struct GlassSignWelcomeCard<Actions: View>: View {
	private let actions: Actions
	
	init(@ViewBuilder actions: () -> Actions) {
		self.actions = actions()
	}
	
	var body: some View {
		glassSurface
			.frame(maxWidth: 460)
	}
	
	@ViewBuilder
	private var glassSurface: some View {
		if #available(iOS 26.0, *) {
			cardContent.glassEffect(.regular, in: .rect(cornerRadius: 30))
		} else {
			cardContent.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
		}
	}
	
	private var cardContent: some View {
		VStack(alignment: .leading, spacing: 22) {
			HStack(spacing: 13) {
				ZStack {
					Circle()
						.fill(.white.opacity(0.14))
						.frame(width: 48, height: 48)
					Image(systemName: "signature")
						.font(.system(size: 21, weight: .semibold))
						.foregroundStyle(.white)
				}
				.overlay(Circle().stroke(.white.opacity(0.32), lineWidth: 1))
				
				VStack(alignment: .leading, spacing: 3) {
					Text("GLASSSIGN")
						.font(.caption.weight(.bold))
						.tracking(1.8)
						.foregroundStyle(.white)
					Text(.localized("Personal signing studio"))
						.font(.footnote)
						.foregroundStyle(.white.opacity(0.68))
				}
				Spacer(minLength: 8)
				Image(systemName: "lock.shield.fill")
					.font(.system(size: 17, weight: .medium))
					.foregroundStyle(Color(red: 0.48, green: 0.94, blue: 0.85))
			}
			
			VStack(alignment: .leading, spacing: 10) {
				Text(.localized("Your apps, ready to install."))
					.font(.system(size: 31, weight: .bold, design: .rounded))
					.tracking(-0.65)
					.foregroundStyle(.white)
					.fixedSize(horizontal: false, vertical: true)
				Text(.localized("Import an IPA, choose your certificate, then sign and install it on this iPhone."))
					.font(.subheadline)
					.lineSpacing(4)
					.foregroundStyle(.white.opacity(0.74))
					.fixedSize(horizontal: false, vertical: true)
			}
			
			actions
				.foregroundStyle(.white)
			
			HStack(spacing: 8) {
				Image(systemName: "key.horizontal.fill")
					.foregroundStyle(Color(red: 0.48, green: 0.94, blue: 0.85))
				Text(.localized("Add a certificate in Settings to start signing."))
					.foregroundStyle(.white.opacity(0.72))
					.fixedSize(horizontal: false, vertical: true)
			}
			.font(.caption)
		}
		.padding(24)
		.background {
			RoundedRectangle(cornerRadius: 30, style: .continuous)
				.fill(
					LinearGradient(
						colors: [
							Color(red: 0.20, green: 0.27, blue: 0.49).opacity(0.72),
							Color(red: 0.10, green: 0.16, blue: 0.32).opacity(0.52)
						],
						startPoint: .topLeading,
						endPoint: .bottomTrailing
					)
				)
		}
		.overlay {
			RoundedRectangle(cornerRadius: 30, style: .continuous)
				.stroke(.white.opacity(0.22), lineWidth: 1)
		}
		.shadow(color: Color(red: 0.16, green: 0.31, blue: 0.77).opacity(0.20), radius: 28, y: 15)
	}
}
