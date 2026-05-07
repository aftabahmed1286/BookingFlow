//
//  BookingCoordinator.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//
import Foundation
import Observation

// MARK: - Coordinator

@MainActor
@Observable
final class BookingCoordinator {

    // MARK: Published

    var state: BookingState = .search

    var path: [Route] = [] {
        didSet {
            // If path becomes empty, ensure state is .search
            if path.isEmpty && state != .search {
                state = .search
            }
            // Add more sync logic here if needed
        }
    }

    // MARK: Context

    private(set) var context = BookingContext()

    // MARK: Private

    private let stateMachine = BookingStateMachine()

    // MARK: Public

    func send(_ action: BookingAction) {

        capture(action)

        let newState = stateMachine.transition(
            state: state,
            action: action
        )

        state = newState

        updateRoute(for: newState)

        handleEffects(action)
    }

    // MARK: Capture Context

    private func capture(_ action: BookingAction) {

        switch action {

        case .searchTapped(let query):
            context.query = query

        case .searchSuccess(let flights):
            context.flights = flights

        case .flightSelected(let flight):
            context.selectedFlight = flight

        case .travellerSubmitted(let travellers):
            context.travellers = travellers

        case .paySuccess(let booking):
            context.booking = booking

        default:
            break
        }
    }

    // MARK: Navigation

    private func updateRoute(for state: BookingState) {

        switch state {

        case .search:
            path = []

        case .flights:
            path = [.flights]

        case .flightDetail:
            path = [.flights, .flightDetail]

        case .traveller:
            path = [.flights, .flightDetail,  .traveller]

        case .processingPayment,
             .paymentError:

            path = [.flights, .flightDetail,  .traveller, .payment]

        case .confirmation:
            path = [.confirmation]

        default:
            break
        }
    }

    // MARK: Effects

    private func handleEffects(_ action: BookingAction) {

        switch action {

        case .searchTapped:
            performFlightSearch()

        case .payTapped:
            processPayment()

        default:
            break
        }
    }

    // MARK: Mock APIs

    private func performFlightSearch() {

        Task {

            try? await Task.sleep(for: .seconds(1))

            let flights = [
                Flight(id: UUID(), name: "Indigo"),
                Flight(id: UUID(), name: "Air India"),
                Flight(id: UUID(), name: "Emirates")
            ]

            send(.searchSuccess(flights))
        }
    }

    private func processPayment() {

        Task {

            try? await Task.sleep(for: .seconds(2))

            let booking = Booking(
                id: UUID(),
                reference: "AERO123"
            )

            send(.paySuccess(booking))
        }
    }
}
