//
//  ConfirmationView.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//


import SwiftUI
// MARK: - Confirmation

struct ConfirmationView: View {

    @Environment(BookingCoordinator.self) var coordinator

    var body: some View {

        VStack(spacing: 24) {

            Text("Booking Confirmed")
                .font(.largeTitle.bold())

            Text(
                coordinator.context.booking?.reference ?? ""
            )

            Button("Done") {
                coordinator.send(.confirmDoneTapped)
            }
        }
        .padding()
    }
}