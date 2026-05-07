// MARK: - Context

struct BookingContext {

    var query: SearchQuery?

    var flights: [Flight] = []

    var selectedFlight: Flight?

    var travellers: [Traveller] = []

    var booking: Booking?
}
