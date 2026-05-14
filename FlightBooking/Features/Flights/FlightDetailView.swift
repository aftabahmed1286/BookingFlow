//
//  FlightDetailView.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//


import SwiftUI
// MARK: - Flight Detail

struct FlightDetailView: View {

    @Environment(Coordinator.self) var coordinator

    var body: some View {

        VStack(spacing: 24) {

            Text(coordinator.context.selectedFlight?.name ?? "")
                .font(.title.bold())

            Button("Add Traveller") {

                let travellers = [
                    Traveller(
                        id: UUID(),
                        name: "Aftab"
                    )
                ]

                coordinator.send(
                    .travellerSubmitted(travellers)
                )
            }
        }
        .padding()
    }
}

