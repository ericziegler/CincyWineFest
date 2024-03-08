//
//  WineDetailsView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI

struct WineDetailsView: View {
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState
    
    @State private var isShowingAlert = false
    @State private var notes: String = ""
    
    var body: some View {
        NavigationStack {
            PageBackground {
                if let wine = appState.selectedWine {
                    renderDetails(for: wine)
                } else {
                    renderErrorView()
                }
            }
            .appNavBar(title: "Details", trailing: renderCloseButton())
            .alert(appState.alertInfo?.title ?? "",
                   isPresented: $isShowingAlert,
                   actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(appState.alertInfo?.message ?? "")
            })
            .onAppear(perform: {
                self.notes = appState.selectedWine?.notes ?? ""
            })
            .onDisappear(perform: {
                if let wine = appState.selectedWine {
                    appState.updateNotes(notes: notes, for: wine)
                }
            })
        }
    }
    
    @ViewBuilder private func renderDetails(for wine: Wine) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            renderTitle(for: wine)
            renderWinery(for: wine)
            AppDivider()
            renderRating(for: wine)
            AppDivider()
            renderNotes(for: wine)
            Spacer()
        }
        .frame(alignment: .leading)
        .foregroundStyle(Color.textPrimary)
        .padding()
    }
    
    @ViewBuilder private func renderTitle(for wine: Wine) -> some View {
        HStack {
            AnyView(wine.medal.icon)
                .frame(height: 36)
            Text(wine.name)
                .font(.appLargeTitle)
        }
    }
    
    @ViewBuilder private func renderWinery(for wine: Wine) -> some View {
        HStack {
            Text(appState.winery(for: wine)?.name.uppercased() ?? "")
                .foregroundStyle(Color.textSecondary)
                .font(.appBoldText)
            Spacer()
            FlagsView(countries: appState.winery(for: wine)?.countries ?? []) { country in
                appState.showAlert(for: country)
                isShowingAlert = true
            }
        }
    }
    
    @ViewBuilder private func renderRating(for wine: Wine) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("My Rating:")
                .font(.appBoldText)
                .foregroundStyle(Color.textPrimary)
            RatingView(rating: wine.rating ?? 0) { rating in
                appState.updateRating(rating: rating, for: wine)
            }
        }
    }
    
    @ViewBuilder private func renderNotes(for wine: Wine) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("My Notes:")
                .font(.appBoldText)
                .foregroundStyle(Color.textPrimary)
            TextEditor(text: $notes)
                .foregroundStyle(.textPrimary)
                .padding(.horizontal, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.appSeparator, lineWidth: 1)
                )
        }
    }
    
    @ViewBuilder private func renderErrorView() -> some View {
        NoContentView(title: "Ouch!",
                      message: "Something went majorly wrong. This is on me, not you...")
    }
    
    @ViewBuilder private func renderCloseButton() -> some View {
        HStack {
            Image(systemName: "xmark")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(height: 22)
        }
        .frame(width: 35, height: 35)
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    WineDetailsView()
        .environmentObject(AppState())
}
