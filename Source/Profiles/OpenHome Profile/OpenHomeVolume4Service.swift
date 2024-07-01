import Foundation
import Combine
import XMLCoder
import os.log

public class OpenHomeVolume4Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct CharacteristicsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case volumeMax = "VolumeMax"
			case volumeUnity = "VolumeUnity"
			case volumeSteps = "VolumeSteps"
			case volumeMilliDbPerStep = "VolumeMilliDbPerStep"
			case balanceMax = "BalanceMax"
			case fadeMax = "FadeMax"
		}

		public var volumeMax: UInt32
		public var volumeUnity: UInt32
		public var volumeSteps: UInt32
		public var volumeMilliDbPerStep: UInt32
		public var balanceMax: UInt32
		public var fadeMax: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))CharacteristicsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeMax: \(volumeMax)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeUnity: \(volumeUnity)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeSteps: \(volumeSteps)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeMilliDbPerStep: \(volumeMilliDbPerStep)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))balanceMax: \(balanceMax)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))fadeMax: \(fadeMax)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func characteristics(log: UPnPService.MessageLog = .none) async throws -> CharacteristicsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Characteristics"
				case response = "u:CharacteristicsResponse"
			}

			var action: SoapAction?
			var response: CharacteristicsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Characteristics", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setVolume(value: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case value = "Value"
			}

			@Attribute var urn: String
			public var value: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetVolume"
			}

			var action: SoapAction
		}
		try await post(action: "SetVolume", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), value: value))), log: log)
	}

	public func volumeInc(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:VolumeInc"
			}

			var action: SoapAction
		}
		try await post(action: "VolumeInc", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func volumeDec(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:VolumeDec"
			}

			var action: SoapAction
		}
		try await post(action: "VolumeDec", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func setVolumeNoUnmute(value: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case value = "Value"
			}

			@Attribute var urn: String
			public var value: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetVolumeNoUnmute"
			}

			var action: SoapAction
		}
		try await post(action: "SetVolumeNoUnmute", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), value: value))), log: log)
	}

	public func volumeIncNoUnmute(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:VolumeIncNoUnmute"
			}

			var action: SoapAction
		}
		try await post(action: "VolumeIncNoUnmute", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func volumeDecNoUnmute(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:VolumeDecNoUnmute"
			}

			var action: SoapAction
		}
		try await post(action: "VolumeDecNoUnmute", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public struct VolumeResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))VolumeResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func volume(log: UPnPService.MessageLog = .none) async throws -> VolumeResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Volume"
				case response = "u:VolumeResponse"
			}

			var action: SoapAction?
			var response: VolumeResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Volume", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setBalance(value: Int32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case value = "Value"
			}

			@Attribute var urn: String
			public var value: Int32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetBalance"
			}

			var action: SoapAction
		}
		try await post(action: "SetBalance", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), value: value))), log: log)
	}

	public func balanceInc(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:BalanceInc"
			}

			var action: SoapAction
		}
		try await post(action: "BalanceInc", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func balanceDec(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:BalanceDec"
			}

			var action: SoapAction
		}
		try await post(action: "BalanceDec", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public struct BalanceResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: Int32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))BalanceResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func balance(log: UPnPService.MessageLog = .none) async throws -> BalanceResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Balance"
				case response = "u:BalanceResponse"
			}

			var action: SoapAction?
			var response: BalanceResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Balance", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setFade(value: Int32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case value = "Value"
			}

			@Attribute var urn: String
			public var value: Int32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetFade"
			}

			var action: SoapAction
		}
		try await post(action: "SetFade", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), value: value))), log: log)
	}

	public func fadeInc(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:FadeInc"
			}

			var action: SoapAction
		}
		try await post(action: "FadeInc", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func fadeDec(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:FadeDec"
			}

			var action: SoapAction
		}
		try await post(action: "FadeDec", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public struct FadeResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: Int32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))FadeResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func fade(log: UPnPService.MessageLog = .none) async throws -> FadeResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Fade"
				case response = "u:FadeResponse"
			}

			var action: SoapAction?
			var response: FadeResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Fade", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setMute(value: Bool, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case value = "Value"
			}

			@Attribute var urn: String
			public var value: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetMute"
			}

			var action: SoapAction
		}
		try await post(action: "SetMute", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), value: value))), log: log)
	}

	public struct MuteResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))MuteResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func mute(log: UPnPService.MessageLog = .none) async throws -> MuteResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Mute"
				case response = "u:MuteResponse"
			}

			var action: SoapAction?
			var response: MuteResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Mute", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct VolumeLimitResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))VolumeLimitResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func volumeLimit(log: UPnPService.MessageLog = .none) async throws -> VolumeLimitResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:VolumeLimit"
				case response = "u:VolumeLimitResponse"
			}

			var action: SoapAction?
			var response: VolumeLimitResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "VolumeLimit", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct UnityGainResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case value = "Value"
		}

		public var value: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))UnityGainResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))value: \(value == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func unityGain(log: UPnPService.MessageLog = .none) async throws -> UnityGainResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:UnityGain"
				case response = "u:UnityGainResponse"
			}

			var action: SoapAction?
			var response: UnityGainResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "UnityGain", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct VolumeOffsetResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case volumeOffsetBinaryMilliDb = "VolumeOffsetBinaryMilliDb"
		}

		public var volumeOffsetBinaryMilliDb: Int32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))VolumeOffsetResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeOffsetBinaryMilliDb: \(volumeOffsetBinaryMilliDb)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func volumeOffset(channel: String, log: UPnPService.MessageLog = .none) async throws -> VolumeOffsetResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case channel = "Channel"
			}

			@Attribute var urn: String
			public var channel: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:VolumeOffset"
				case response = "u:VolumeOffsetResponse"
			}

			var action: SoapAction?
			var response: VolumeOffsetResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "VolumeOffset", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), channel: channel))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setVolumeOffset(channel: String, volumeOffsetBinaryMilliDb: Int32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case channel = "Channel"
				case volumeOffsetBinaryMilliDb = "VolumeOffsetBinaryMilliDb"
			}

			@Attribute var urn: String
			public var channel: String
			public var volumeOffsetBinaryMilliDb: Int32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetVolumeOffset"
			}

			var action: SoapAction
		}
		try await post(action: "SetVolumeOffset", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), channel: channel, volumeOffsetBinaryMilliDb: volumeOffsetBinaryMilliDb))), log: log)
	}

	public struct TrimResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case trimBinaryMilliDb = "TrimBinaryMilliDb"
		}

		public var trimBinaryMilliDb: Int32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))TrimResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))trimBinaryMilliDb: \(trimBinaryMilliDb)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func trim(channel: String, log: UPnPService.MessageLog = .none) async throws -> TrimResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case channel = "Channel"
			}

			@Attribute var urn: String
			public var channel: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Trim"
				case response = "u:TrimResponse"
			}

			var action: SoapAction?
			var response: TrimResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Trim", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), channel: channel))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setTrim(channel: String, trimBinaryMilliDb: Int32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case channel = "Channel"
				case trimBinaryMilliDb = "TrimBinaryMilliDb"
			}

			@Attribute var urn: String
			public var channel: String
			public var trimBinaryMilliDb: Int32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetTrim"
			}

			var action: SoapAction
		}
		try await post(action: "SetTrim", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), channel: channel, trimBinaryMilliDb: trimBinaryMilliDb))), log: log)
	}

}

// Event parser
extension OpenHomeVolume4Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case volume = "Volume"
			case mute = "Mute"
			case balance = "Balance"
			case fade = "Fade"
			case volumeLimit = "VolumeLimit"
			case volumeMax = "VolumeMax"
			case volumeUnity = "VolumeUnity"
			case volumeSteps = "VolumeSteps"
			case volumeMilliDbPerStep = "VolumeMilliDbPerStep"
			case balanceMax = "BalanceMax"
			case fadeMax = "FadeMax"
			case unityGain = "UnityGain"
			case volumeOffsets = "VolumeOffsets"
			case volumeOffsetMax = "VolumeOffsetMax"
			case trim = "Trim"
		}

		public var volume: UInt32?
		public var mute: Bool?
		public var balance: Int32?
		public var fade: Int32?
		public var volumeLimit: UInt32?
		public var volumeMax: UInt32?
		public var volumeUnity: UInt32?
		public var volumeSteps: UInt32?
		public var volumeMilliDbPerStep: UInt32?
		public var balanceMax: UInt32?
		public var fadeMax: UInt32?
		public var unityGain: Bool?
		public var volumeOffsets: String?
		public var volumeOffsetMax: UInt32?
		public var trim: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))OpenHomeVolume4ServiceState {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volume: \(volume ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))mute: \((mute == nil) ? "nil" : (mute! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))balance: \(balance ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))fade: \(fade ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeLimit: \(volumeLimit ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeMax: \(volumeMax ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeUnity: \(volumeUnity ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeSteps: \(volumeSteps ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeMilliDbPerStep: \(volumeMilliDbPerStep ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))balanceMax: \(balanceMax ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))fadeMax: \(fadeMax ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))unityGain: \((unityGain == nil) ? "nil" : (unityGain! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeOffsets: '\(volumeOffsets ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))volumeOffsetMax: \(volumeOffsetMax ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))trim: '\(trim ?? "nil")'")
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
			if let volume = property.volume {
				result.volume = volume
			}
			if let mute = property.mute {
				result.mute = mute
			}
			if let balance = property.balance {
				result.balance = balance
			}
			if let fade = property.fade {
				result.fade = fade
			}
			if let volumeLimit = property.volumeLimit {
				result.volumeLimit = volumeLimit
			}
			if let volumeMax = property.volumeMax {
				result.volumeMax = volumeMax
			}
			if let volumeUnity = property.volumeUnity {
				result.volumeUnity = volumeUnity
			}
			if let volumeSteps = property.volumeSteps {
				result.volumeSteps = volumeSteps
			}
			if let volumeMilliDbPerStep = property.volumeMilliDbPerStep {
				result.volumeMilliDbPerStep = volumeMilliDbPerStep
			}
			if let balanceMax = property.balanceMax {
				result.balanceMax = balanceMax
			}
			if let fadeMax = property.fadeMax {
				result.fadeMax = fadeMax
			}
			if let unityGain = property.unityGain {
				result.unityGain = unityGain
			}
			if let volumeOffsets = property.volumeOffsets {
				result.volumeOffsets = volumeOffsets
			}
			if let volumeOffsetMax = property.volumeOffsetMax {
				result.volumeOffsetMax = volumeOffsetMax
			}
			if let trim = property.trim {
				result.trim = trim
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
