//
//  BookingRootView.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//
import SwiftUI

// MARK: - Root View

class MockFlightService: FlightServiceProtocol  {

    func searchFlights(_ query: SearchQuery) async throws -> [Flight] {

            try? await Task.sleep(for: .seconds(1))

            let flights = [
                Flight(id: UUID(), name: "Indigo"),
                Flight(id: UUID(), name: "Air India"),
                Flight(id: UUID(), name: "Emirates")
            ]

            return flights

    }
    
    func processPayment(_ flight: Flight, _ travellers: [Traveller]) async throws -> Booking {

        try? await Task.sleep(for: .seconds(2))

        let booking = Booking(
            id: UUID(),
            reference: "AERO123"
        )

        return booking
    }

}

struct BookingRootView: View {

    @State private var coordinator = BookingCoordinator(flightService: MockFlightService())

    var body: some View {

        NavigationStack(path: $coordinator.path) {

            SearchView()
                .navigationBarBackButtonHidden(
                    !coordinator.state.allowsBackNavigation
                )
                .navigationDestination(for: Route.self) { route in

                    switch route {

                    case .flights:
                        FlightsView()

                    case .flightDetail:
                        FlightDetailView()

                    case .traveller:
                        TravellerView()

                    case .payment:
                        PaymentView()

                    case .confirmation:
                        ConfirmationView()
                    }
                }
        }
        .environment(coordinator)
    }
}
