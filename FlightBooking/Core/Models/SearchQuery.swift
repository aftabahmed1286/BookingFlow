//
//  SearchQuery.swift
//  FlightBooking
//
//  Created by Aftab on 07/05/26.
//


// MARK: - Entities

struct SearchQuery: Equatable {
    let from: String
    let to: String
}

struct Flight: Identifiable, Equatable {
    let id: UUID
    let name: String
}

struct Traveller: Identifiable, Equatable {
    let id: UUID
    let name: String
}

struct Booking: Equatable {
    let id: UUID
    let reference: String
}