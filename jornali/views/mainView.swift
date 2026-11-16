import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = JournalViewModel()

    // These only control what's on screen, so they stay in the view
    @State private var editingJournal: Journal?
    @State private var journalToDelete: Journal?
    @State private var showDeleteAlert = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .ignoresSafeArea()

            VStack {
                // Header
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()

                    HStack(spacing: 20) {
                        Menu {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Button(option.rawValue) {
                                    viewModel.sortOption = option
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                        Button {
                            editingJournal = Journal(title: "", date: Date(), content: "", isBookmarked: false)
                        } label: {
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

                // Content: empty state OR list
                if viewModel.journals.isEmpty {
                    Spacer()

                    VStack(spacing: 12) {
                        Image("EmptyBook")
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
                } else {
                    List {
                        ForEach(viewModel.displayedJournals) { journal in
                            JournalCard(
                                title: journal.title,
                                date: journal.date.formatted(date: .numeric, time: .omitted),
                                content: journal.content,
                                isBookmarked: journal.isBookmarked,
                                onBookmarkTap: { viewModel.toggleBookmark(journal) }
                            )
                            .onTapGesture {
                                editingJournal = journal
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    journalToDelete = journal
                                    showDeleteAlert = true
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(Color("Destructive"))
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .safeAreaInset(edge: .bottom) {
                        Color.clear.frame(height: 80)
                    }
                }
            }

            // Floating search bar
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $viewModel.searchText)
                    .foregroundColor(.white)
                Image(systemName: "mic.fill")
            }
            .foregroundColor(Color("TextSecondary"))
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(.ultraThinMaterial, in: Capsule())
            .padding(.horizontal, 20)
        }
        .sheet(item: $editingJournal) { journal in
            JournalEditorView(journal: journal) { saved in
                viewModel.save(saved)
            }
        }
        .alert("Delete Journal?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let journal = journalToDelete {
                    viewModel.delete(journal)
                }
            }
        } message: {
            Text("Are you sure you want to delete this journal?")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
