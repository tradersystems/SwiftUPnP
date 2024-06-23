import Foundation
import Combine
import XMLCoder
import os.log

public class linncoukDiagnostics1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct EchoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aOut = "aOut"
		}

		public var aOut: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))EchoResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aOut: '\(aOut)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func echo(aIn: String, log: UPnPService.MessageLog = .none) async throws -> EchoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aIn = "aIn"
			}

			@Attribute var urn: String
			public var aIn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Echo"
				case response = "u:EchoResponse"
			}

			var action: SoapAction?
			var response: EchoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Echo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aIn: aIn))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ElfFileResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aElfFile = "aElfFile"
		}

		public var aElfFile: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ElfFileResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aElfFile: '\(aElfFile)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func elfFile(log: UPnPService.MessageLog = .none) async throws -> ElfFileResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ElfFile"
				case response = "u:ElfFileResponse"
			}

			var action: SoapAction?
			var response: ElfFileResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ElfFile", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ElfFingerprintResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aElfFileFingerprint = "aElfFileFingerprint"
		}

		public var aElfFileFingerprint: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ElfFingerprintResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aElfFileFingerprint: '\(aElfFileFingerprint)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func elfFingerprint(log: UPnPService.MessageLog = .none) async throws -> ElfFingerprintResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ElfFingerprint"
				case response = "u:ElfFingerprintResponse"
			}

			var action: SoapAction?
			var response: ElfFingerprintResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ElfFingerprint", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct CrashDataStatusResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aCrashDataStatus = "aCrashDataStatus"
		}

		public var aCrashDataStatus: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))CrashDataStatusResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aCrashDataStatus: '\(aCrashDataStatus)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func crashDataStatus(log: UPnPService.MessageLog = .none) async throws -> CrashDataStatusResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:CrashDataStatus"
				case response = "u:CrashDataStatusResponse"
			}

			var action: SoapAction?
			var response: CrashDataStatusResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "CrashDataStatus", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct CrashDataFetchResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aCrashDataData = "aCrashData"
		}

		public var aCrashDataData: Data?
		public var aCrashData: [UInt32]? {
			aCrashDataData?.toArray(type: UInt32.self).map { $0.bigEndian }
		}

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))CrashDataFetchResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func crashDataFetch(log: UPnPService.MessageLog = .none) async throws -> CrashDataFetchResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:CrashDataFetch"
				case response = "u:CrashDataFetchResponse"
			}

			var action: SoapAction?
			var response: CrashDataFetchResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "CrashDataFetch", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func crashDataClear(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:CrashDataClear"
			}

			var action: SoapAction
		}
		try await post(action: "CrashDataClear", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public struct SysLogResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aSysLogData = "aSysLog"
		}

		public var aSysLogData: Data?
		public var aSysLog: [UInt32]? {
			aSysLogData?.toArray(type: UInt32.self).map { $0.bigEndian }
		}

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))SysLogResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func sysLog(log: UPnPService.MessageLog = .none) async throws -> SysLogResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SysLog"
				case response = "u:SysLogResponse"
			}

			var action: SoapAction?
			var response: SysLogResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "SysLog", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct DiagnosticResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aDiagnosticInfo = "aDiagnosticInfo"
		}

		public var aDiagnosticInfo: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))DiagnosticResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aDiagnosticInfo: '\(aDiagnosticInfo)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func diagnostic(aDiagnosticType: String, log: UPnPService.MessageLog = .none) async throws -> DiagnosticResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aDiagnosticType = "aDiagnosticType"
			}

			@Attribute var urn: String
			public var aDiagnosticType: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Diagnostic"
				case response = "u:DiagnosticResponse"
			}

			var action: SoapAction?
			var response: DiagnosticResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Diagnostic", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aDiagnosticType: aDiagnosticType))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct DiagnosticTestResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aDiagnosticInfo = "aDiagnosticInfo"
			case aDiagnosticResult = "aDiagnosticResult"
		}

		public var aDiagnosticInfo: String
		public var aDiagnosticResult: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))DiagnosticTestResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aDiagnosticInfo: '\(aDiagnosticInfo)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aDiagnosticResult: \(aDiagnosticResult == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func diagnosticTest(aDiagnosticType: String, aDiagnosticInput: String, log: UPnPService.MessageLog = .none) async throws -> DiagnosticTestResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aDiagnosticType = "aDiagnosticType"
				case aDiagnosticInput = "aDiagnosticInput"
			}

			@Attribute var urn: String
			public var aDiagnosticType: String
			public var aDiagnosticInput: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:DiagnosticTest"
				case response = "u:DiagnosticTestResponse"
			}

			var action: SoapAction?
			var response: DiagnosticTestResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "DiagnosticTest", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aDiagnosticType: aDiagnosticType, aDiagnosticInput: aDiagnosticInput))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct StateVariableResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aStateVariable = "aStateVariable"
		}

		public var aStateVariable: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))StateVariableResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aStateVariable: \(aStateVariable)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func stateVariable(log: UPnPService.MessageLog = .none) async throws -> StateVariableResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:StateVariable"
				case response = "u:StateVariableResponse"
			}

			var action: SoapAction?
			var response: StateVariableResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "StateVariable", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setStateVariable(aStateVariable: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aStateVariable = "aStateVariable"
			}

			@Attribute var urn: String
			public var aStateVariable: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetStateVariable"
			}

			var action: SoapAction
		}
		try await post(action: "SetStateVariable", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aStateVariable: aStateVariable))), log: log)
	}

	public struct StateVariablePeriodResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aPeriod = "aPeriod"
		}

		public var aPeriod: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))StateVariablePeriodResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aPeriod: \(aPeriod)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func stateVariablePeriod(log: UPnPService.MessageLog = .none) async throws -> StateVariablePeriodResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:StateVariablePeriod"
				case response = "u:StateVariablePeriodResponse"
			}

			var action: SoapAction?
			var response: StateVariablePeriodResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "StateVariablePeriod", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setStateVariablePeriod(aPeriod: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aPeriod = "aPeriod"
			}

			@Attribute var urn: String
			public var aPeriod: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetStateVariablePeriod"
			}

			var action: SoapAction
		}
		try await post(action: "SetStateVariablePeriod", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aPeriod: aPeriod))), log: log)
	}

	public func reboot(aDelay: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aDelay = "aDelay"
			}

			@Attribute var urn: String
			public var aDelay: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Reboot"
			}

			var action: SoapAction
		}
		try await post(action: "Reboot", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aDelay: aDelay))), log: log)
	}

	public func setSongcastPercentageLoss(aPercentage: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aPercentage = "aPercentage"
			}

			@Attribute var urn: String
			public var aPercentage: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetSongcastPercentageLoss"
			}

			var action: SoapAction
		}
		try await post(action: "SetSongcastPercentageLoss", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aPercentage: aPercentage))), log: log)
	}

}

// Event parser
extension linncoukDiagnostics1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case aStateVariable = "aStateVariable"
			case lastTerminalInputCode = "LastTerminalInputCode"
			case lastTerminalInputName = "LastTerminalInputName"
		}

		public var aStateVariable: UInt32?
		public var lastTerminalInputCode: UInt32?
		public var lastTerminalInputName: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))linncouk-Diagnostics-1State {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aStateVariable: \(aStateVariable ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))lastTerminalInputCode: \(lastTerminalInputCode ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))lastTerminalInputName: '\(lastTerminalInputName ?? "nil")'")
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
			if let aStateVariable = property.aStateVariable {
				result.aStateVariable = aStateVariable
			}
			if let lastTerminalInputCode = property.lastTerminalInputCode {
				result.lastTerminalInputCode = lastTerminalInputCode
			}
			if let lastTerminalInputName = property.lastTerminalInputName {
				result.lastTerminalInputName = lastTerminalInputName
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
