import Foundation
import Combine
import XMLCoder
import os.log

public class linncoukExakt2_4Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct GetDeviceListResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case list = "List"
		}

		public var list: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetDeviceListResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))list: '\(list)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getDeviceList(log: UPnPService.MessageLog = .none) async throws -> GetDeviceListResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetDeviceList"
				case response = "u:GetDeviceListResponse"
			}

			var action: SoapAction?
			var response: GetDeviceListResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetDeviceList", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetDeviceSettingsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case settings = "Settings"
		}

		public var settings: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetDeviceSettingsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))settings: '\(settings)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getDeviceSettings(deviceId: String, log: UPnPService.MessageLog = .none) async throws -> GetDeviceSettingsResponse {
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
				case action = "u:GetDeviceSettings"
				case response = "u:GetDeviceSettingsResponse"
			}

			var action: SoapAction?
			var response: GetDeviceSettingsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetDeviceSettings", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), deviceId: deviceId))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetSettingsAvailableResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case settingsAvailable = "SettingsAvailable"
		}

		public var settingsAvailable: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetSettingsAvailableResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))settingsAvailable: \(settingsAvailable == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getSettingsAvailable(log: UPnPService.MessageLog = .none) async throws -> GetSettingsAvailableResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetSettingsAvailable"
				case response = "u:GetSettingsAvailableResponse"
			}

			var action: SoapAction?
			var response: GetSettingsAvailableResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetSettingsAvailable", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetSettingsChangedSeqResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case settingsChangedSeq = "SettingsChangedSeq"
		}

		public var settingsChangedSeq: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetSettingsChangedSeqResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))settingsChangedSeq: '\(settingsChangedSeq)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getSettingsChangedSeq(log: UPnPService.MessageLog = .none) async throws -> GetSettingsChangedSeqResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetSettingsChangedSeq"
				case response = "u:GetSettingsChangedSeqResponse"
			}

			var action: SoapAction?
			var response: GetSettingsChangedSeqResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetSettingsChangedSeq", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func update(manifest: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case manifest = "Manifest"
			}

			@Attribute var urn: String
			public var manifest: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Update"
			}

			var action: SoapAction
		}
		try await post(action: "Update", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), manifest: manifest))), log: log)
	}

	public func updateBlocking(manifest: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case manifest = "Manifest"
			}

			@Attribute var urn: String
			public var manifest: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:UpdateBlocking"
			}

			var action: SoapAction
		}
		try await post(action: "UpdateBlocking", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), manifest: manifest))), log: log)
	}

	public struct GetUpdateStatusResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case updateStatus = "UpdateStatus"
		}

		public var updateStatus: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetUpdateStatusResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))updateStatus: '\(updateStatus)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getUpdateStatus(log: UPnPService.MessageLog = .none) async throws -> GetUpdateStatusResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetUpdateStatus"
				case response = "u:GetUpdateStatusResponse"
			}

			var action: SoapAction?
			var response: GetUpdateStatusResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetUpdateStatus", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetChannelMapResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case channelMap = "ChannelMap"
		}

		public var channelMap: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetChannelMapResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))channelMap: '\(channelMap)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getChannelMap(log: UPnPService.MessageLog = .none) async throws -> GetChannelMapResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetChannelMap"
				case response = "u:GetChannelMapResponse"
			}

			var action: SoapAction?
			var response: GetChannelMapResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetChannelMap", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetAudioChannelsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case audioChannels = "AudioChannels"
		}

		public var audioChannels: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetAudioChannelsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))audioChannels: '\(audioChannels)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getAudioChannels(log: UPnPService.MessageLog = .none) async throws -> GetAudioChannelsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetAudioChannels"
				case response = "u:GetAudioChannelsResponse"
			}

			var action: SoapAction?
			var response: GetAudioChannelsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetAudioChannels", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetVersionResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case version = "Version"
		}

		public var version: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetVersionResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))version: \(version)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getVersion(log: UPnPService.MessageLog = .none) async throws -> GetVersionResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetVersion"
				case response = "u:GetVersionResponse"
			}

			var action: SoapAction?
			var response: GetVersionResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetVersion", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func applyUpdate(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ApplyUpdate"
			}

			var action: SoapAction
		}
		try await post(action: "ApplyUpdate", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func playTestTrack(channelMap: String, uri: String, metadata: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case channelMap = "ChannelMap"
				case uri = "Uri"
				case metadata = "Metadata"
			}

			@Attribute var urn: String
			public var channelMap: String
			public var uri: String
			public var metadata: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:PlayTestTrack"
			}

			var action: SoapAction
		}
		try await post(action: "PlayTestTrack", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), channelMap: channelMap, uri: uri, metadata: metadata))), log: log)
	}

	public func clearTestTrack(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ClearTestTrack"
			}

			var action: SoapAction
		}
		try await post(action: "ClearTestTrack", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
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

	public struct GetTestTrackPlayingResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case testTrackPlaying = "TestTrackPlaying"
		}

		public var testTrackPlaying: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetTestTrackPlayingResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))testTrackPlaying: \(testTrackPlaying == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getTestTrackPlaying(log: UPnPService.MessageLog = .none) async throws -> GetTestTrackPlayingResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetTestTrackPlaying"
				case response = "u:GetTestTrackPlayingResponse"
			}

			var action: SoapAction?
			var response: GetTestTrackPlayingResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetTestTrackPlaying", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func playTestTrackInternal(channel: String, log: UPnPService.MessageLog = .none) async throws {
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
				case action = "u:PlayTestTrackInternal"
			}

			var action: SoapAction
		}
		try await post(action: "PlayTestTrackInternal", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), channel: channel))), log: log)
	}

	public struct GetCurrentTestTrackChannelResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case currentTestTrackChannel = "CurrentTestTrackChannel"
		}

		public var currentTestTrackChannel: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))GetCurrentTestTrackChannelResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentTestTrackChannel: '\(currentTestTrackChannel)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func getCurrentTestTrackChannel(log: UPnPService.MessageLog = .none) async throws -> GetCurrentTestTrackChannelResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetCurrentTestTrackChannel"
				case response = "u:GetCurrentTestTrackChannelResponse"
			}

			var action: SoapAction?
			var response: GetCurrentTestTrackChannelResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetCurrentTestTrackChannel", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension linncoukExakt2_4Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case deviceList = "DeviceList"
			case settingsAvailable = "SettingsAvailable"
			case settingsChangedSeq = "SettingsChangedSeq"
			case updateStatus = "UpdateStatus"
			case channelMap = "ChannelMap"
			case audioChannels = "AudioChannels"
			case version = "Version"
			case integratedDevicesPresent = "IntegratedDevicesPresent"
			case testTrackPlaying = "TestTrackPlaying"
			case currentTestTrackChannel = "CurrentTestTrackChannel"
		}

		public var deviceList: String?
		public var settingsAvailable: Bool?
		public var settingsChangedSeq: String?
		public var updateStatus: String?
		public var channelMap: String?
		public var audioChannels: String?
		public var version: UInt32?
		public var integratedDevicesPresent: Bool?
		public var testTrackPlaying: Bool?
		public var currentTestTrackChannel: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))linncouk-Exakt2-4State {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))deviceList: '\(deviceList ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))settingsAvailable: \((settingsAvailable == nil) ? "nil" : (settingsAvailable! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))settingsChangedSeq: '\(settingsChangedSeq ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))updateStatus: '\(updateStatus ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))channelMap: '\(channelMap ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))audioChannels: '\(audioChannels ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))version: \(version ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))integratedDevicesPresent: \((integratedDevicesPresent == nil) ? "nil" : (integratedDevicesPresent! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))testTrackPlaying: \((testTrackPlaying == nil) ? "nil" : (testTrackPlaying! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))currentTestTrackChannel: '\(currentTestTrackChannel ?? "nil")'")
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
			if let settingsAvailable = property.settingsAvailable {
				result.settingsAvailable = settingsAvailable
			}
			if let settingsChangedSeq = property.settingsChangedSeq {
				result.settingsChangedSeq = settingsChangedSeq
			}
			if let updateStatus = property.updateStatus {
				result.updateStatus = updateStatus
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
			if let testTrackPlaying = property.testTrackPlaying {
				result.testTrackPlaying = testTrackPlaying
			}
			if let currentTestTrackChannel = property.currentTestTrackChannel {
				result.currentTestTrackChannel = currentTestTrackChannel
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
