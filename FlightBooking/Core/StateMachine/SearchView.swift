import SwiftUI
// MARK: - Search

struct SearchView: View {

    @Environment(BookingCoordinator.self) var coordinator

    var body: some View {

        VStack(spacing: 24) {

            Text("Search Flights")
                .font(.largeTitle.bold())

            Button("Search") {

                let query = SearchQuery(
                    from: "BLR",
                    to: "DXB"
                )

                coordinator.send(.searchTapped(query))
            }

            if coordinator.state == .loadingSearch {
                ProgressView()
            }

            if coordinator.state == .searchError {
                Text("Search Failed")
            }
        }
        .padding()
    }
}

