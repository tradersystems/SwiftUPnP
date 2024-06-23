import Foundation
import Combine
import XMLCoder
import os.log

public class linncoukUpdate3Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct GetSoftwareStatusResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case softwareStatus = "SoftwareStatus"
		}

		public var softwareStatus: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetSoftwareStatusResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))softwareStatus: '\(softwareStatus)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getSoftwareStatus(log: UPnPService.MessageLog = .none) async throws -> GetSoftwareStatusResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetSoftwareStatus"
				case response = "u:GetSoftwareStatusResponse"
			}

			var action: SoapAction?
			var response: GetSoftwareStatusResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetSoftwareStatus", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetExecutorStatusResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case executorStatus = "ExecutorStatus"
		}

		public var executorStatus: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetExecutorStatusResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))executorStatus: '\(executorStatus)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getExecutorStatus(log: UPnPService.MessageLog = .none) async throws -> GetExecutorStatusResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetExecutorStatus"
				case response = "u:GetExecutorStatusResponse"
			}

			var action: SoapAction?
			var response: GetExecutorStatusResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetExecutorStatus", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetJobStatusResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case jobStatus = "JobStatus"
		}

		public var jobStatus: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetJobStatusResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))jobStatus: '\(jobStatus)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getJobStatus(log: UPnPService.MessageLog = .none) async throws -> GetJobStatusResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetJobStatus"
				case response = "u:GetJobStatusResponse"
			}

			var action: SoapAction?
			var response: GetJobStatusResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetJobStatus", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func pushManifest(uri: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case uri = "Uri"
			}

			@Attribute var urn: String
			public var uri: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:PushManifest"
			}

			var action: SoapAction
		}
		try await post(action: "PushManifest", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), uri: uri))), log: log)
	}

	public struct PushManifest2Response: Codable {
		enum CodingKeys: String, CodingKey {
			case id = "Id"
		}

		public var id: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))PushManifest2Response {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))id: \(id)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func pushManifest2(uri: String, log: UPnPService.MessageLog = .none) async throws -> PushManifest2Response {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case uri = "Uri"
			}

			@Attribute var urn: String
			public var uri: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:PushManifest2"
				case response = "u:PushManifest2Response"
			}

			var action: SoapAction?
			var response: PushManifest2Response?
		}
		let result: Envelope<Body> = try await postWithResult(action: "PushManifest2", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), uri: uri))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func apply(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Apply"
			}

			var action: SoapAction
		}
		try await post(action: "Apply", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public struct Apply2Response: Codable {
		enum CodingKeys: String, CodingKey {
			case id = "Id"
		}

		public var id: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))Apply2Response {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))id: \(id)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func apply2(log: UPnPService.MessageLog = .none) async throws -> Apply2Response {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Apply2"
				case response = "u:Apply2Response"
			}

			var action: SoapAction?
			var response: Apply2Response?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Apply2", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func recover(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Recover"
			}

			var action: SoapAction
		}
		try await post(action: "Recover", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public struct Recover2Response: Codable {
		enum CodingKeys: String, CodingKey {
			case id = "Id"
		}

		public var id: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))Recover2Response {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))id: \(id)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func recover2(log: UPnPService.MessageLog = .none) async throws -> Recover2Response {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Recover2"
				case response = "u:Recover2Response"
			}

			var action: SoapAction?
			var response: Recover2Response?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Recover2", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func recoverKeepStore(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:RecoverKeepStore"
			}

			var action: SoapAction
		}
		try await post(action: "RecoverKeepStore", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public struct RecoverKeepStore2Response: Codable {
		enum CodingKeys: String, CodingKey {
			case id = "Id"
		}

		public var id: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))RecoverKeepStore2Response {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))id: \(id)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func recoverKeepStore2(log: UPnPService.MessageLog = .none) async throws -> RecoverKeepStore2Response {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:RecoverKeepStore2"
				case response = "u:RecoverKeepStore2Response"
			}

			var action: SoapAction?
			var response: RecoverKeepStore2Response?
		}
		let result: Envelope<Body> = try await postWithResult(action: "RecoverKeepStore2", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func checkNow(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:CheckNow"
			}

			var action: SoapAction
		}
		try await post(action: "CheckNow", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public struct GetRecoverSupportedResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case recoverSupported = "RecoverSupported"
		}

		public var recoverSupported: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetRecoverSupportedResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))recoverSupported: \(recoverSupported == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getRecoverSupported(log: UPnPService.MessageLog = .none) async throws -> GetRecoverSupportedResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetRecoverSupported"
				case response = "u:GetRecoverSupportedResponse"
			}

			var action: SoapAction?
			var response: GetRecoverSupportedResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetRecoverSupported", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension linncoukUpdate3Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case softwareStatus = "SoftwareStatus"
			case executorStatus = "ExecutorStatus"
			case jobStatus = "JobStatus"
			case recoverSupported = "RecoverSupported"
		}

		public var softwareStatus: String?
		public var executorStatus: String?
		public var jobStatus: String?
		public var recoverSupported: Bool?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))linncouk-Update-3State {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))softwareStatus: '\(softwareStatus ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))executorStatus: '\(executorStatus ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))jobStatus: '\(jobStatus ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))recoverSupported: \((recoverSupported == nil) ? "nil" : (recoverSupported! == true ? "true" : "false"))")
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
			if let softwareStatus = property.softwareStatus {
				result.softwareStatus = softwareStatus
			}
			if let executorStatus = property.executorStatus {
				result.executorStatus = executorStatus
			}
			if let jobStatus = property.jobStatus {
				result.jobStatus = jobStatus
			}
			if let recoverSupported = property.recoverSupported {
				result.recoverSupported = recoverSupported
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
