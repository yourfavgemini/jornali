//
//  JournalEditorView.swift
//  jornali
//
//  Created by Reema on 16/11/2026.
//


import SwiftUI

struct JournalEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var draft: Journal
    @State private var showDiscardAlert = false
    private let original: Journal
    let onSave: (Journal) -> Void

    init(journal: Journal, onSave: @escaping (Journal) -> Void) {
        _draft = State(initialValue: journal)
        self.original = journal
        self.onSave = onSave
    }

    var hasChanges: Bool {
        draft.title != original.title || draft.content != original.content
    }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 12) {
                // Top buttons
                HStack {
                    Button {
                        if hasChanges {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(Circle().fill(Color("CardSurface")))
                    }

                    Spacer()

                    Button {
                        onSave(draft)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(Circle().fill(Color("PrimaryAccent")))
                    }
                }

                // Title and date
                TextField("Title", text: $draft.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                Text(draft.date.formatted(date: .numeric, time: .omitted))
                    .font(.system(size: 14))
                    .foregroundColor(Color("TextSecondary"))

                // Body
                TextEditor(text: $draft.content)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .overlay(alignment: .topLeading) {
                        if draft.content.isEmpty {
                            Text("Type your Journal...")
                                .font(.system(size: 16))
                                .foregroundColor(Color("TextSecondary"))
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                        }
                    }
            }
            .padding(20)
        }
        .overlay {
            if showDiscardAlert {
                ZStack(alignment: .top) {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showDiscardAlert = false
                        }

                    VStack(spacing: 10) {
                        Text("Are you sure you want to discard changes on this journal?")
                            .font(.system(size: 14))
                            .foregroundColor(Color("TextSecondary"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 4)

                        Button {
                            dismiss()
                        } label: {
                            Text("Discard Changes")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("Destructive"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Capsule().fill(Color.white.opacity(0.1)))
                        }

                        Button {
                            showDiscardAlert = false
                        } label: {
                            Text("Keep Editing")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Capsule().fill(Color.white.opacity(0.1)))
                        }
                    }
                    .padding(16)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28))
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showDiscardAlert)
    }
}

struct JournalEditorView_Previews: PreviewProvider {
    static var previews: some View {
        JournalEditorView(
            journal: Journal(title: "", date: Date(), content: "", isBookmarked: false),
            onSave: { _ in }
        )
    }
}