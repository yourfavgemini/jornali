//
//  mainView.swift
//  jornali
//
//  Created by Reema on 11/11/2026.
//
import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .ignoresSafeArea()

            VStack {
                // Header (same as the empty state)
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()

                    HStack(spacing: 20) {
                        Button { } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                        Button { } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Capsule().fill(Color("CardSurface")))
                }
                .padding(.horizontal, 20)

                // Cards
                ScrollView {
                    VStack(spacing: 16) {
                        JournalCard(
                            title: "My Birthday",
                            date: "02/09/2024",
                            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis.",
                            isBookmarked: true
                        )
                        // Add your other two cards here
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }

            // Floating search bar
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Search")
                Spacer()
                Image(systemName: "mic.fill")
            }
            .foregroundColor(Color("TextSecondary"))
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(.ultraThinMaterial, in: Capsule())
            .padding(.horizontal, 20)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
