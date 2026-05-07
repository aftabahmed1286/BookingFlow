// MARK: - Action

enum BookingAction {

    case searchTapped(SearchQuery)

    case searchSuccess([Flight])
    case searchFailed(BookingError)

    case flightSelected(Flight)

    case travellerSubmitted([Traveller])

    case payTapped
    case paySuccess(Booking)
    case payFailed(BookingError)

    case confirmDoneTapped

    case backTapped
}