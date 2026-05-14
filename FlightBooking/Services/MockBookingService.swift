//
//  MockFlightService.swift
//  FlightBooking
//
//  Created by Aftab on 09/05/26.
//
import Foundation

// MARK: - Mock

class MockBookingService: BookingServiceProtocol  {

    func searchFlights(_ query: SearchQuery) async throws -> [Flight] {

        try? await Task.sleep(for: .seconds(1))

        let flights = [
            Flight(id: UUID(), name: "Indigo"),
            Flight(id: UUID(), name: "Air India"),
            Flight(id: UUID(), name: "Emirates")
        ]

        return flights

    }

    func processPayment(_ flight: Flight, _ travellers: [Traveller]) async throws -> Booking {

        try? await Task.sleep(for: .seconds(2))

        let booking = Booking(
            id: UUID(),
            reference: "AERO123"
        )

        return booking
    }

}
