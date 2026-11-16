//
//  journal.swift
//  jornali
//
//  Created by Reema on 12/11/2026.
//
import Foundation

struct Journal: Identifiable, Codable {
    var id = UUID()
    var title: String
    var date: Date
    var content: String
    var isBookmarked: Bool
}
