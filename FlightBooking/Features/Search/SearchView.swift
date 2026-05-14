//
//  SearchView.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//


import SwiftUI
// MARK: - Search

struct SearchView: View {

    @Environment(Coordinator.self) var coordinator

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

