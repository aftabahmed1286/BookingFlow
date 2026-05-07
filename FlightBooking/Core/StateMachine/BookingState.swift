//
//  BookingState.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//

// MARK: - State

enum BookingState: Equatable {

    case search
    case loadingSearch
    case searchError

    case flights
    case flightDetail

    case traveller

    case processingPayment
    case paymentError

    case confirmation
}

extension BookingState {

    var allowsBackNavigation: Bool {

        switch self {

        case .loadingSearch,
             .processingPayment,
             .confirmation
            :
            return false

        default:
            return true
        }
    }
}
