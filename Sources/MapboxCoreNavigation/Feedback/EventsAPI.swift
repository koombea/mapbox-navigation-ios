import Foundation
@_implementationOnly import MapboxCommon_Private

protocol EventsAPI {
    func sendTurnstileEvent(sdkIdentifier: String, sdkVersion: String)
    func sendEvent(with attributes: [String: Any])
}

extension EventsService: EventsAPI {
    func sendTurnstileEvent(sdkIdentifier: String, sdkVersion: String) {
        let turnstileEvent = TurnstileEvent(skuId: .nav2SesMAU, sdkIdentifier: sdkIdentifier, sdkVersion: sdkVersion)
        sendTurnstileEvent(for: turnstileEvent)
    }

    func sendEvent(with attributes: [String : Any]) {
        let priority: EventPriority = EventsApiConfiguration.delaysEventFlushing ? .queued : .immediate
        sendEvent(for: Event(priority: priority, attributes: attributes, deferredOptions: nil))
    }
}

@_spi(MapboxInternal) public final class EventsApiConfiguration {
    public static var delaysEventFlushing = true
}
