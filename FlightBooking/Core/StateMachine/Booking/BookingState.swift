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

    //Routes
    var routes: [Route] {
        switch self {
        case .search, .loadingSearch, .searchError:
            return []
        case .flights:
            return [
                .flights
            ]
        case .flightDetail:
            return [
                .flights,
                    .flightDetail
            ]
        case .traveller:
            return [
                .flights,
                    .flightDetail,
                    .traveller
            ]
        case .processingPayment, .paymentError:
            return [
                .flights,
                    .flightDetail,
                    .traveller,
                    .payment
            ]
        case .confirmation:
            return [
                .flights,
                    .flightDetail,
                    .traveller,
                    .payment,
                    .confirmation
            ]
        }
    }

}

extension BookingState {

    init(path: [Route]) {

        switch path.last {

        case nil:
            self = .search

        case .flights:
            self = .flights

        case .flightDetail:
            self = .flightDetail

        case .traveller:
            self = .traveller

        case .payment:
            self = .processingPayment

        case .confirmation:
            self = .confirmation
        }
    }
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
