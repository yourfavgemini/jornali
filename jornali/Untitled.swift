//
//  Untitled.swift
//  MyApp
//
//  Created by Reema on 10/11/2026.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                
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

                Spacer()

               
                
                
                VStack(spacing: 12) {
                    Image("book")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)

                    Text("Begin Your Journal")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("TextAccent"))

                    Text("Craft your personal diary, tap the plus icon to begin")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 40)

                Spacer()

                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                    Spacer()
                    Image(systemName: "mic.fill")
                }
                .foregroundColor(Color("TextSecondary"))
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Capsule().fill(Color("CardSurface")))
                .padding(.horizontal, 20)
            }
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()
    }
}
