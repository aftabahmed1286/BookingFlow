////
////  BookingCoordinator.swift
////  FlightBooking
////
////  Created by Aftab on 07/05/26.
////
//import Foundation
//import Observation
//
//// MARK: - Coordinator
//
//
//@MainActor
//@Observable
//final class BookingCoordinator {
//
//    // MARK: Published
//    var state: BookingState = .search
//    var path: [Route] = []
//
//    // MARK: Context
//    private(set) var context = BookingContext()
//    // MARK: Private
//    private let reducer: BookingStateReducer
//
//    private let flightService: FlightServiceProtocol
//
//    init(
//        reducer: BookingStateReducer,
//        flightService: FlightServiceProtocol
//    ) {
//        self.reducer = reducer
//        self.flightService = flightService
//    }
//
//    // MARK: Public
//
//    func send(_ action: BookingAction) {
//
//        let newState = reducer.reduce(
//            state: state,
//            action: action
//        )
//
//        if newState != state {
//            capture(action)
//            state = newState
//            path = state.routes
//            handleEffects(action)
//        }
//    }
//
//    func didNavigate(to path: [Route]) {
//
//        self.path = path
//        self.state = BookingState(path: path)
//
//    }
//}
//
//extension BookingCoordinator {
//
//    // MARK: Effects
//
//    private func handleEffects(_ action: BookingAction) {
//
//        switch action {
//
//        case .searchTapped:
//            Task {
//                guard let query = context.query,
//                      let flights = try? await flightService.searchFlights(query) else {
//                    return
//                }
//                send(.searchSuccess(flights))
//            }
//        case .payTapped:
//            guard let flight = context.selectedFlight
//                     else {
//                return
//            }
//            let travellers = context.travellers
//            Task {
//                guard let booking = try? await flightService.processPayment(flight, travellers) else {
//                    return
//                }
//                send(.paySuccess(booking))
//            }
//        default:
//            break
//        }
//    }
//
//}
//
//extension BookingCoordinator {
//
//    // MARK: Capture Context
//
//    private func capture(_ action: BookingAction) {
//
//        switch action {
//
//        case .searchTapped(let query):
//            context.query = query
//
//        case .searchSuccess(let flights):
//            context.flights = flights
//
//        case .flightSelected(let flight):
//            context.selectedFlight = flight
//
//        case .travellerSubmitted(let travellers):
//            context.travellers = travellers
//
//        case .paySuccess(let booking):
//            context.booking = booking
//
//        default:
//            break
//        }
//    }
//}
