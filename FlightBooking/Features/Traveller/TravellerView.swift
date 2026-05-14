//
//  TravellerView.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//


import SwiftUI
// MARK: - Traveller

struct TravellerView: View {

    @Environment(Coordinator.self) var coordinator

    var body: some View {

        VStack(spacing: 24) {

            Text("Travellers")
                .font(.title.bold())

            ForEach(coordinator.context.travellers) { traveller in
                Text(traveller.name)
            }

            Button("Proceed To Payment") {
                coordinator.send(.payTapped)
            }
        }
        .padding()
    }
}

