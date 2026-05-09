# BookingFlow

A modern state-driven airline booking flow built using SwiftUI, Observation Framework, Coordinator Pattern, and a lightweight finite state machine architecture.

The project demonstrates how complex booking journeys can be modeled using:

- Lightweight UI states
- Explicit user actions
- Centralized navigation coordination
- Context-driven data capture
- Async side effects
- Predictable state transitions

The goal of this project is to explore scalable architecture patterns commonly used in airline and OTA (Online Travel Agency) applications.

---

# Features

- SwiftUI + Observation Framework
- State Machine Driven Flow
- Coordinator-based Navigation
- Context-based Data Persistence
- Async Effect Handling
- Scalable Route Management
- Clean Separation of Concerns
- Simple Mock APIs
- Retry Handling for Search & Payment
- NavigationStack-based Flow

---

# Architecture Overview

The project is divided into the following core concepts:

| Component | Responsibility |
|---|---|
| BookingState | Represents the current UI/workflow state |
| BookingAction | Represents user/system events |
| BookingContext | Stores accumulated booking data |
| BookingEffect | Handles async operations |
| Route | Represents navigation destinations |
| BookingCoordinator | Orchestrates flow and navigation |
| BookingStateMachine | Controls valid transitions |
| Entities | Business/domain models |

---

# Booking Flow

```text
Search
    ↓
LoadingSearch
    ↓
Flights
    ↓
FlightDetail
    ↓
Traveller
    ↓
ProcessingPayment
    ↓
Confirmation
```

Error states:

```text
LoadingSearch → SearchError
ProcessingPayment → PaymentError
```

---

# State Machine

The application uses a lightweight finite state machine.

```swift
State + Action -> New State
```

Example:

```swift
(.search, .searchTapped)
    -> .loadingSearch

(.loadingSearch, .searchSuccess)
    -> .flights
```

This ensures:

- Predictable navigation
- Safer transitions
- Easier debugging
- Easier testing
- Reduced invalid states

---

# BookingContext

The `BookingContext` captures data progressively during the booking journey.

```swift
struct BookingContext {

    var query: SearchQuery?

    var flights: [Flight] = []

    var selectedFlight: Flight?

    var travellers: [Traveller] = []

    var booking: Booking?
}
```

Instead of storing payloads inside states, the project keeps states lightweight and stores accumulated data inside the context.

---

# Coordinator Pattern

`BookingCoordinator` acts as the single orchestration layer.

Responsibilities:

- Receives actions
- Updates context
- Runs state transitions
- Triggers navigation
- Executes async effects

Example:

```swift
coordinator.send(.searchTapped(query))
```

---

# Observation Framework

The project uses Apple's modern Observation Framework.

```swift
@Observable
final class BookingCoordinator
```

Views access the coordinator using:

```swift
@Environment(BookingCoordinator.self)
private var coordinator
```

---

# Navigation

Navigation is powered using:

```swift
NavigationStack(path:)
```

Routes are modeled separately:

```swift
enum Route {
    case flights
    case flightDetail
    case traveller
    case payment
    case confirmation
}
```

---

# Folder Structure

```text
BookingFlow
│
├── App
│   └── BookingDemoApp.swift
│
├── Coordinator
│   └── BookingCoordinator.swift
│
├── StateMachine
│   ├── BookingState.swift
│   ├── BookingAction.swift
│   ├── BookingStateMachine.swift
│   └── BookingEffect.swift
│
├── Context
│   └── BookingContext.swift
│
├── Navigation
│   └── Route.swift
│
├── Models
│   ├── Flight.swift
│   ├── Traveller.swift
│   ├── Booking.swift
│   ├── SearchQuery.swift
│   └── BookingError.swift
│
├── Views
│   ├── Search
│   ├── Flights
│   ├── FlightDetail
│   ├── Traveller
│   ├── Payment
│   └── Confirmation
│
└── Services
    └── MockBookingService.swift
```

---

# Future Improvements

- Dependency Injection
- Real API Integration
- Unit Tests
- Snapshot Testing
- Deep Linking
- Persistence & Session Restore
- Multi-city Booking
- Seat Selection
- Fare Families
- Redux-style Reducer Layer
- Modular Swift Packages
- Analytics Tracking
- Offline Support

---

# Why This Architecture?

Traditional booking apps often become difficult to scale due to:

- Massive ViewControllers
- Mixed navigation logic
- Stateful UI inconsistencies
- Tight coupling
- Callback-heavy async code

This project explores a cleaner alternative:

- Explicit transitions
- Predictable workflows
- Centralized orchestration
- Testable business flow
- Scalable navigation structure

---

# Requirements

- iOS 17+
- Xcode 16+
- Swift 6

---

# Tech Stack

- SwiftUI
- Observation Framework
- NavigationStack
- Swift Concurrency
- MVVM-inspired Flow Coordination
- Finite State Machine Architecture

---

# Inspiration

This project is inspired by scalable workflow architectures commonly seen in:

- Airline booking systems
- OTA platforms
- E-commerce checkout flows
- State-driven frontend architectures
- Redux / Elm style systems

---

# License

MIT License
