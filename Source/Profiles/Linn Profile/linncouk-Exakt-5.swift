import Foundation
import Combine
import XMLCoder
import os.log

public class linncoukExakt5Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct DeviceListResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case list = "List"
		}

		public var list: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))DeviceListResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))list: '\(list)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func deviceList(log: UPnPService.MessageLog = .none) async throws -> DeviceListResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:DeviceList"
				case response = "u:DeviceListResponse"
			}

			var action: SoapAction?
			var response: DeviceListResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "DeviceList", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct DeviceSettingsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case settings = "Settings"
		}

		public var settings: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))DeviceSettingsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))settings: '\(settings)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func deviceSettings(deviceId: String, log: UPnPService.MessageLog = .none) async throws -> DeviceSettingsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case deviceId = "DeviceId"
			}

			@Attribute var urn: String
			public var deviceId: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:DeviceSettings"
				case response = "u:DeviceSettingsResponse"
			}

			var action: SoapAction?
			var response: DeviceSettingsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "DeviceSettings", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), deviceId: deviceId))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ConnectionStatusResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case connectionStatus = "ConnectionStatus"
		}

		public var connectionStatus: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ConnectionStatusResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))connectionStatus: '\(connectionStatus)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func connectionStatus(log: UPnPService.MessageLog = .none) async throws -> ConnectionStatusResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ConnectionStatus"
				case response = "u:ConnectionStatusResponse"
			}

			var action: SoapAction?
			var response: ConnectionStatusResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ConnectionStatus", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func set(deviceId: String, bankId: UInt32, fileUri: String, mute: Bool, persist: Bool, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case deviceId = "DeviceId"
				case bankId = "BankId"
				case fileUri = "FileUri"
				case mute = "Mute"
				case persist = "Persist"
			}

			@Attribute var urn: String
			public var deviceId: String
			public var bankId: UInt32
			public var fileUri: String
			public var mute: Bool
			public var persist: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Set"
			}

			var action: SoapAction
		}
		try await post(action: "Set", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), deviceId: deviceId, bankId: bankId, fileUri: fileUri, mute: mute, persist: persist))), log: log)
	}

	public func reprogram(deviceId: String, fileUri: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case deviceId = "DeviceId"
				case fileUri = "FileUri"
			}

			@Attribute var urn: String
			public var deviceId: String
			public var fileUri: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Reprogram"
			}

			var action: SoapAction
		}
		try await post(action: "Reprogram", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), deviceId: deviceId, fileUri: fileUri))), log: log)
	}

	public func reprogramFallback(deviceId: String, fileUri: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case deviceId = "DeviceId"
				case fileUri = "FileUri"
			}

			@Attribute var urn: String
			public var deviceId: String
			public var fileUri: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ReprogramFallback"
			}

			var action: SoapAction
		}
		try await post(action: "ReprogramFallback", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), deviceId: deviceId, fileUri: fileUri))), log: log)
	}

	public struct ChannelMapResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case channelMap = "ChannelMap"
		}

		public var channelMap: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ChannelMapResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))channelMap: '\(channelMap)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func channelMap(log: UPnPService.MessageLog = .none) async throws -> ChannelMapResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ChannelMap"
				case response = "u:ChannelMapResponse"
			}

			var action: SoapAction?
			var response: ChannelMapResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ChannelMap", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setChannelMap(channelMap: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case channelMap = "ChannelMap"
			}

			@Attribute var urn: String
			public var channelMap: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetChannelMap"
			}

			var action: SoapAction
		}
		try await post(action: "SetChannelMap", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), channelMap: channelMap))), log: log)
	}

	public struct AudioChannelsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case audioChannels = "AudioChannels"
		}

		public var audioChannels: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))AudioChannelsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))audioChannels: '\(audioChannels)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func audioChannels(log: UPnPService.MessageLog = .none) async throws -> AudioChannelsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:AudioChannels"
				case response = "u:AudioChannelsResponse"
			}

			var action: SoapAction?
			var response: AudioChannelsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "AudioChannels", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setAudioChannels(audioChannels: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case audioChannels = "AudioChannels"
			}

			@Attribute var urn: String
			public var audioChannels: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetAudioChannels"
			}

			var action: SoapAction
		}
		try await post(action: "SetAudioChannels", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), audioChannels: audioChannels))), log: log)
	}

	public struct VersionResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case version = "Version"
		}

		public var version: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))VersionResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))version: '\(version)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func version(log: UPnPService.MessageLog = .none) async throws -> VersionResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Version"
				case response = "u:VersionResponse"
			}

			var action: SoapAction?
			var response: VersionResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Version", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetIntegratedDevicesPresentResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case integratedDevicesPresent = "IntegratedDevicesPresent"
		}

		public var integratedDevicesPresent: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetIntegratedDevicesPresentResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))integratedDevicesPresent: \(integratedDevicesPresent == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getIntegratedDevicesPresent(log: UPnPService.MessageLog = .none) async throws -> GetIntegratedDevicesPresentResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetIntegratedDevicesPresent"
				case response = "u:GetIntegratedDevicesPresentResponse"
			}

			var action: SoapAction?
			var response: GetIntegratedDevicesPresentResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetIntegratedDevicesPresent", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func bootIntegratedDevicesToFallback(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:BootIntegratedDevicesToFallback"
			}

			var action: SoapAction
		}
		try await post(action: "BootIntegratedDevicesToFallback", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func reboot(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Reboot"
			}

			var action: SoapAction
		}
		try await post(action: "Reboot", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

}

// Event parser
extension linncoukExakt5Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case deviceList = "DeviceList"
			case connectionStatus = "ConnectionStatus"
			case channelMap = "ChannelMap"
			case audioChannels = "AudioChannels"
			case version = "Version"
			case integratedDevicesPresent = "IntegratedDevicesPresent"
		}

		public var deviceList: String?
		public var connectionStatus: String?
		public var channelMap: String?
		public var audioChannels: String?
		public var version: String?
		public var integratedDevicesPresent: Bool?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))linncouk-Exakt-5State {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))deviceList: '\(deviceList ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))connectionStatus: '\(connectionStatus ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))channelMap: '\(channelMap ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))audioChannels: '\(audioChannels ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))version: '\(version ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))integratedDevicesPresent: \((integratedDevicesPresent == nil) ? "nil" : (integratedDevicesPresent! == true ? "true" : "false"))")
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
			if let deviceList = property.deviceList {
				result.deviceList = deviceList
			}
			if let connectionStatus = property.connectionStatus {
				result.connectionStatus = connectionStatus
			}
			if let channelMap = property.channelMap {
				result.channelMap = channelMap
			}
			if let audioChannels = property.audioChannels {
				result.audioChannels = audioChannels
			}
			if let version = property.version {
				result.version = version
			}
			if let integratedDevicesPresent = property.integratedDevicesPresent {
				result.integratedDevicesPresent = integratedDevicesPresent
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
