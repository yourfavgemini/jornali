//
//  journalViewModel.swift
//  jornali
//
//  Created by Reema on 15/11/2026.
//
import SwiftUI
import Combine

enum SortOption: String, CaseIterable {
    case entryDate = "Sort by Entry Date"
    case bookmark = "Sort by Bookmark"
}

class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = []
    @Published var searchText = ""
    @Published var sortOption: SortOption = .entryDate

    init() {
        loadFromDisk()
    }

    // The list the screen shows: filtered by search, then sorted
    var displayedJournals: [Journal] {
        var result = journals

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .entryDate:
            result.sort { $0.date > $1.date }
        case .bookmark:
            result.sort { a, b in
                if a.isBookmarked != b.isBookmarked { return a.isBookmarked }
                return a.date > b.date
            }
        }
        return result
    }

    func save(_ saved: Journal) {
        if let index = journals.firstIndex(where: { $0.id == saved.id }) {
            journals[index] = saved
        } else {
            journals.insert(saved, at: 0)
        }
        saveToDisk()
    }

    func toggleBookmark(_ journal: Journal) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index].isBookmarked.toggle()
            saveToDisk()
        }
    }

    func delete(_ journal: Journal) {
        journals.removeAll { $0.id == journal.id }
        saveToDisk()
    }

    private func saveToDisk() {
        if let data = try? JSONEncoder().encode(journals) {
            UserDefaults.standard.set(data, forKey: "journals")
        }
    }

    private func loadFromDisk() {
        if let data = UserDefaults.standard.data(forKey: "journals"),
           let saved = try? JSONDecoder().decode([Journal].self, from: data) {
            journals = saved
        }
    }
}
