import Foundation
import Combine
import XMLCoder
import os.log

public class linncoukCloud2Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public enum AssociationStatusEnum: String, Codable {
		case associated = "Associated"
		case notAssociated = "NotAssociated"
		case unconfigured = "Unconfigured"
	}

	public struct GetChallengeResponseResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case response = "Response"
		}

		public var response: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetChallengeResponseResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))response: '\(response)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getChallengeResponse(challenge: String, log: UPnPService.MessageLog = .none) async throws -> GetChallengeResponseResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case challenge = "Challenge"
			}

			@Attribute var urn: String
			public var challenge: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetChallengeResponse"
				case response = "u:GetChallengeResponseResponse"
			}

			var action: SoapAction?
			var response: GetChallengeResponseResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetChallengeResponse", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), challenge: challenge))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setAssociated(aesKeyRsaEncrypted: Data, initVectorRsaEncrypted: Data, tokenAesEncrypted: Data, associated: Bool, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aesKeyRsaEncrypted = "AesKeyRsaEncrypted"
				case initVectorRsaEncrypted = "InitVectorRsaEncrypted"
				case tokenAesEncrypted = "TokenAesEncrypted"
				case associated = "Associated"
			}

			@Attribute var urn: String
			public var aesKeyRsaEncrypted: Data
			public var initVectorRsaEncrypted: Data
			public var tokenAesEncrypted: Data
			public var associated: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetAssociated"
			}

			var action: SoapAction
		}
		try await post(action: "SetAssociated", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aesKeyRsaEncrypted: aesKeyRsaEncrypted, initVectorRsaEncrypted: initVectorRsaEncrypted, tokenAesEncrypted: tokenAesEncrypted, associated: associated))), log: log)
	}

	public struct GetConnectedResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case connected = "Connected"
		}

		public var connected: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetConnectedResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))connected: \(connected == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getConnected(log: UPnPService.MessageLog = .none) async throws -> GetConnectedResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetConnected"
				case response = "u:GetConnectedResponse"
			}

			var action: SoapAction?
			var response: GetConnectedResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetConnected", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetAccountIdResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case accountId = "AccountId"
		}

		public var accountId: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetAccountIdResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))accountId: '\(accountId)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getAccountId(log: UPnPService.MessageLog = .none) async throws -> GetAccountIdResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetAccountId"
				case response = "u:GetAccountIdResponse"
			}

			var action: SoapAction?
			var response: GetAccountIdResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetAccountId", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetPublicKeyResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case publicKey = "PublicKey"
		}

		public var publicKey: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetPublicKeyResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))publicKey: '\(publicKey)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getPublicKey(log: UPnPService.MessageLog = .none) async throws -> GetPublicKeyResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetPublicKey"
				case response = "u:GetPublicKeyResponse"
			}

			var action: SoapAction?
			var response: GetPublicKeyResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetPublicKey", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension linncoukCloud2Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case associationStatus = "AssociationStatus"
			case connected = "Connected"
			case accountId = "AccountId"
			case publicKey = "PublicKey"
		}

		public var associationStatus: AssociationStatusEnum?
		public var connected: Bool?
		public var accountId: String?
		public var publicKey: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))linncouk-Cloud-2State {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))associationStatus: \(associationStatus?.rawValue ?? "nil")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))connected: \((connected == nil) ? "nil" : (connected! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))accountId: '\(accountId ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))publicKey: '\(publicKey ?? "nil")'")
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
			if let associationStatus = property.associationStatus {
				result.associationStatus = associationStatus
			}
			if let connected = property.connected {
				result.connected = connected
			}
			if let accountId = property.accountId {
				result.accountId = accountId
			}
			if let publicKey = property.publicKey {
				result.publicKey = publicKey
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
