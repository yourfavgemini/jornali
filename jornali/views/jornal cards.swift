//
//  jornal cards.swift
//  jornali
//
//  Created by Reema on 11/11/2026.
//
import SwiftUI

struct JournalCard: View {
    let title: String
    let date: String
    let content: String
    let isBookmarked: Bool
    let onBookmarkTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color("TextAccent"))

                Spacer()
                
                Button {
                                    onBookmarkTap()
                                } label: {
                Image(systemName: isBookmarked ?
                      "bookmark.fill" : "bookmark")
                    .font(.system(size: 22))
                    .foregroundColor(Color("TextAccent"))
            }
                .buttonStyle(.plain)
}
            
            Text(date)
                .font(.system(size: 14))
                .foregroundColor(Color("TextSecondary"))

            Text(content)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding(.top, 8)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("CardSurface"))
        .cornerRadius(24)
    }
}

struct JournalCard_Previews: PreviewProvider {
    static var previews: some View {
        JournalCard(
            title: "My Birthday",
            date: "02/09/2024",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",
            isBookmarked: true,
            onBookmarkTap: { }
        )
        .padding()
        .background(Color.black)
    }
}
