//
//  BookingRootView.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//


// MARK: - Root View

struct BookingRootView: View {

    @State private var coordinator = BookingCoordinator()

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