//
//  FlightsView.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//


import SwiftUI
// MARK: - Flights

struct FlightsView: View {

    @Environment(Coordinator.self) var coordinator

    var body: some View {

        List(coordinator.context.flights) { flight in

            Button(flight.name) {
                coordinator.send(.flightSelected(flight))
            }
        }
        .navigationTitle("Flights")
    }
}

