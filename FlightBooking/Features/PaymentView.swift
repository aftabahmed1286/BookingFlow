import SwiftUI
// MARK: - Payment

struct PaymentView: View {

    @Environment(BookingCoordinator.self) var coordinator

    var body: some View {

        VStack(spacing: 24) {

            Text("Payment")
                .font(.title.bold())

            if coordinator.state == .processingPayment {
                ProgressView("Processing...")
            }

            if coordinator.state == .paymentError {

                Button("Retry Payment") {
                    coordinator.send(.payTapped)
                }
            }
        }
        .padding()
    }
}


