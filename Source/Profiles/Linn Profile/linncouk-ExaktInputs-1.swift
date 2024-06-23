import Foundation
import Combine
import XMLCoder
import os.log

public class linncoukExaktInputs1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct GetAssociationResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case deviceId = "DeviceId"
		}

		public var deviceId: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetAssociationResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))deviceId: '\(deviceId)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getAssociation(inputIndex: UInt32, log: UPnPService.MessageLog = .none) async throws -> GetAssociationResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case inputIndex = "InputIndex"
			}

			@Attribute var urn: String
			public var inputIndex: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetAssociation"
				case response = "u:GetAssociationResponse"
			}

			var action: SoapAction?
			var response: GetAssociationResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetAssociation", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), inputIndex: inputIndex))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setAssociation(inputIndex: UInt32, deviceId: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case inputIndex = "InputIndex"
				case deviceId = "DeviceId"
			}

			@Attribute var urn: String
			public var inputIndex: UInt32
			public var deviceId: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetAssociation"
			}

			var action: SoapAction
		}
		try await post(action: "SetAssociation", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), inputIndex: inputIndex, deviceId: deviceId))), log: log)
	}

	public func clearAssociation(inputIndex: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case inputIndex = "InputIndex"
			}

			@Attribute var urn: String
			public var inputIndex: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ClearAssociation"
			}

			var action: SoapAction
		}
		try await post(action: "ClearAssociation", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), inputIndex: inputIndex))), log: log)
	}

	public struct InputCountResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case inputCount = "InputCount"
		}

		public var inputCount: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))InputCountResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))inputCount: \(inputCount)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func inputCount(log: UPnPService.MessageLog = .none) async throws -> InputCountResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:InputCount"
				case response = "u:InputCountResponse"
			}

			var action: SoapAction?
			var response: InputCountResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "InputCount", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension linncoukExaktInputs1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case associations = "Associations"
		}

		public var associations: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))linncouk-ExaktInputs-1State {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))associations: '\(associations ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}

	public func state(xml: Data) throws -> State {
		struct PropertySet: Codable {
			var property: [State]
		}

		let decoder = XMLDecoder()
		decoder.shouldProcessNamespaces = true
		let propertySet = try decoder.decode(PropertySet.self, from: xml)

		return propertySet.property.reduce(State()) { partialResult, property in
			var result = partialResult
			if let associations = property.associations {
				result.associations = associations
			}
			return result
		}
	}

	public var stateSubject: AnyPublisher<State, Never> {
		subscribedEventPublisher
			.compactMap { [weak self] in
				guard let self else { return nil }

				return try? self.state(xml: $0)
			}
			.eraseToAnyPublisher()
	}

	public var stateChangeStream: AsyncStream<State> {
		stateSubject.stream
	}
}
