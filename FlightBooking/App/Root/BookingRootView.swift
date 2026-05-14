//
//  BookingRootView.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//
import SwiftUI

// MARK: - Root View

struct BookingRootView: View {

    @State private var bookingCoordinator = Coordinator(
        reducer: BookingStateMachine(),
        flightService: MockFlightService()
    )

    var body: some View {

        NavigationStack(path:
                            // $bookingCoordinator.path
                        Binding(
                            get: { bookingCoordinator.path },
                            set: { newPath in
                                bookingCoordinator.didNavigate(to: newPath)
                            }
                        )
        ) {

            SearchView()
                .navigationBarBackButtonHidden(
                    !bookingCoordinator.state.allowsBackNavigation
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
        .environment(bookingCoordinator)
    }
}
