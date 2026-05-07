//
//  BookingStateMachine.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//


// MARK: - State Machine

struct BookingStateMachine {

    func transition(
        state: BookingState,
        action: BookingAction
    ) -> BookingState {

        switch (state, action) {

        case (.search, .searchTapped):
            return .loadingSearch

        case (.loadingSearch, .searchSuccess):
            return .flights

        case (.loadingSearch, .searchFailed):
            return .searchError

        case (.searchError, .searchTapped):
            return .loadingSearch

        case (.flights, .flightSelected):
            return .flightDetail

        case (.flightDetail, .travellerSubmitted):
            return .traveller

        case (.traveller, .payTapped):
            return .processingPayment

        case (.processingPayment, .paySuccess):
            return .confirmation

        case (.processingPayment, .payFailed):
            return .paymentError

        case (.paymentError, .payTapped):
            return .processingPayment

        case (.confirmation, .confirmDoneTapped):
            return .search

        default:
            return state
        }
    }
}