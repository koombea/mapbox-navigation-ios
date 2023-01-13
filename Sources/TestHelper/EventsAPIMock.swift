import Foundation
@testable import MapboxCoreNavigation

class EventsAPIMock: EventsAPI {
    private typealias MockEvent = [String: Any]

    private var events = [MockEvent]()

    func sendTurnstileEvent(sdkIdentifier: String, sdkVersion: String) {
        events.append([EventKey.event.rawValue: EventType.turnstile.rawValue])
    }

    func sendEvent(with attributes: [String: Any]) {
        events.append(attributes)
    }

    func reset() {
        events.removeAll()
    }

    func hasEvent(with name: String) -> Bool {
        return hasEvent(in: events, key: .event, value: name)
    }

    func eventCount(with name: String) -> Int {
        return events.filter { (event) in
            return event[EventKey.event.rawValue] as? String == name
        }.count
    }

    private func hasEvent<ValueType>(in array: [MockEvent], key: EventKey, value: ValueType) -> Bool where ValueType: Comparable {
        return array.contains { (event) -> Bool in
            guard
                let eventValue = event[key.rawValue] as? ValueType,
                eventValue == value
            else { return false }
            return true
        }
    }
}
