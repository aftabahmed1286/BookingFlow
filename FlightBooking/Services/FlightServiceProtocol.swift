//
//  FlightServiceProtocol.swift
//  FlightBooking
//
//  Created by Aftab on 09/05/26.
//

protocol FlightServiceProtocol {
    func searchFlights( _ query: SearchQuery) async throws -> [Flight]
    func processPayment( _ flight: Flight, _ travellers: [Traveller]) async throws -> Booking
}
