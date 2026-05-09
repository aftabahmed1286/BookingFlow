//
//  BookingCoordinator.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//
import Foundation
import Observation

// MARK: - Coordinator

protocol FlightServiceProtocol {
    func searchFlights( _ query: SearchQuery) async throws -> [Flight]
    func processPayment( _ flight: Flight, _ travellers: [Traveller]) async throws -> Booking
}

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

    private let flightService: FlightServiceProtocol

    init(flightService: FlightServiceProtocol) {
        self.flightService = flightService
    }

    // MARK: Public

    func send(_ action: BookingAction) {

        let newState = stateMachine.reduce(
            state: state,
            action: action
        )

        if newState != state {
            capture(action)
            state = newState
            updateRoute(for: newState)
            handleEffects(action)
        }
    }
}


extension BookingCoordinator {

    // MARK: Navigation

    private func updateRoute(for state: BookingState) {

        switch state {

        case .search:
            path = []

        case .flights:
            path = [
                .flights
            ]

        case .flightDetail:
            path = [
                .flights,
                .flightDetail
            ]

        case .traveller:
            path = [
                .flights,
                .flightDetail,
                .traveller
            ]

        case .processingPayment,
             .paymentError:

            path = [
                .flights,
                .flightDetail,
                .traveller,
                .payment
            ]

        case .confirmation:
            path = [
                .flights,
                .flightDetail,
                .traveller,
                .payment,
                .confirmation
            ]

        default:
            break
        }
    }
}

extension BookingCoordinator {

    // MARK: Effects

    private func handleEffects(_ action: BookingAction) {

        switch action {

        case .searchTapped:
            Task {
                guard let query = context.query,
                      let flights = try? await flightService.searchFlights(query) else {
                    return
                }
                send(.searchSuccess(flights))
            }
        case .payTapped:
            guard let flight = context.selectedFlight
                     else {
                return
            }
            let travellers = context.travellers
            Task {
                guard let booking = try? await flightService.processPayment(flight, travellers) else {
                    return
                }
                send(.paySuccess(booking))
            }
        default:
            break
        }
    }

}

extension BookingCoordinator {

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
}
