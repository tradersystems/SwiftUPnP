import Foundation
import Combine
import XMLCoder
import os.log

public class linncoukVolkano2Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public enum A_ARG_TYPE_BootMode_aModeEnum: String, Codable {
		case fallback = "Fallback"
		case main = "Main"
		case ram = "Ram"
	}

	public enum A_ARG_TYPE_SetBootMode_aModeEnum: String, Codable {
		case fallback = "Fallback"
		case main = "Main"
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

	public struct BootModeResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aMode = "aMode"
		}

		public var aMode: A_ARG_TYPE_BootMode_aModeEnum

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))BootModeResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aMode: \(aMode.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func bootMode(log: UPnPService.MessageLog = .none) async throws -> BootModeResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:BootMode"
				case response = "u:BootModeResponse"
			}

			var action: SoapAction?
			var response: BootModeResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "BootMode", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setBootMode(aMode: A_ARG_TYPE_SetBootMode_aModeEnum, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aMode = "aMode"
			}

			@Attribute var urn: String
			public var aMode: A_ARG_TYPE_SetBootMode_aModeEnum
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetBootMode"
			}

			var action: SoapAction
		}
		try await post(action: "SetBootMode", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aMode: aMode))), log: log)
	}

	public struct BspTypeResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aBspType = "aBspType"
		}

		public var aBspType: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))BspTypeResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aBspType: '\(aBspType)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func bspType(log: UPnPService.MessageLog = .none) async throws -> BspTypeResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:BspType"
				case response = "u:BspTypeResponse"
			}

			var action: SoapAction?
			var response: BspTypeResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "BspType", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct UglyNameResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aUglyName = "aUglyName"
		}

		public var aUglyName: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))UglyNameResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aUglyName: '\(aUglyName)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func uglyName(log: UPnPService.MessageLog = .none) async throws -> UglyNameResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:UglyName"
				case response = "u:UglyNameResponse"
			}

			var action: SoapAction?
			var response: UglyNameResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "UglyName", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct IpAddressResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aIpAddress = "aIpAddress"
		}

		public var aIpAddress: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))IpAddressResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aIpAddress: '\(aIpAddress)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func ipAddress(log: UPnPService.MessageLog = .none) async throws -> IpAddressResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:IpAddress"
				case response = "u:IpAddressResponse"
			}

			var action: SoapAction?
			var response: IpAddressResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "IpAddress", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct IpAddressListResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aIpAddressList = "aIpAddressList"
		}

		public var aIpAddressList: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))IpAddressListResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aIpAddressList: '\(aIpAddressList)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func ipAddressList(log: UPnPService.MessageLog = .none) async throws -> IpAddressListResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:IpAddressList"
				case response = "u:IpAddressListResponse"
			}

			var action: SoapAction?
			var response: IpAddressListResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "IpAddressList", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct MacAddressResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aMacAddress = "aMacAddress"
		}

		public var aMacAddress: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))MacAddressResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aMacAddress: '\(aMacAddress)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func macAddress(log: UPnPService.MessageLog = .none) async throws -> MacAddressResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:MacAddress"
				case response = "u:MacAddressResponse"
			}

			var action: SoapAction?
			var response: MacAddressResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "MacAddress", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct MacAddressListResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aMacAddressList = "aMacAddressList"
		}

		public var aMacAddressList: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))MacAddressListResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aMacAddressList: '\(aMacAddressList)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func macAddressList(log: UPnPService.MessageLog = .none) async throws -> MacAddressListResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:MacAddressList"
				case response = "u:MacAddressListResponse"
			}

			var action: SoapAction?
			var response: MacAddressListResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "MacAddressList", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ProductIdResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aProductNumber = "aProductNumber"
		}

		public var aProductNumber: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ProductIdResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aProductNumber: '\(aProductNumber)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func productId(log: UPnPService.MessageLog = .none) async throws -> ProductIdResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ProductId"
				case response = "u:ProductIdResponse"
			}

			var action: SoapAction?
			var response: ProductIdResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ProductId", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct BoardIdResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aBoardNumber = "aBoardNumber"
		}

		public var aBoardNumber: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))BoardIdResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aBoardNumber: '\(aBoardNumber)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func boardId(aIndex: UInt32, log: UPnPService.MessageLog = .none) async throws -> BoardIdResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aIndex = "aIndex"
			}

			@Attribute var urn: String
			public var aIndex: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:BoardId"
				case response = "u:BoardIdResponse"
			}

			var action: SoapAction?
			var response: BoardIdResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "BoardId", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aIndex: aIndex))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct BoardTypeResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aBoardNumber = "aBoardNumber"
		}

		public var aBoardNumber: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))BoardTypeResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aBoardNumber: '\(aBoardNumber)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func boardType(aIndex: UInt32, log: UPnPService.MessageLog = .none) async throws -> BoardTypeResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aIndex = "aIndex"
			}

			@Attribute var urn: String
			public var aIndex: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:BoardType"
				case response = "u:BoardTypeResponse"
			}

			var action: SoapAction?
			var response: BoardTypeResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "BoardType", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aIndex: aIndex))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct MaxBoardsResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aMaxBoards = "aMaxBoards"
		}

		public var aMaxBoards: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))MaxBoardsResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aMaxBoards: \(aMaxBoards)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func maxBoards(log: UPnPService.MessageLog = .none) async throws -> MaxBoardsResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:MaxBoards"
				case response = "u:MaxBoardsResponse"
			}

			var action: SoapAction?
			var response: MaxBoardsResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "MaxBoards", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct SoftwareVersionResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aSoftwareVersion = "aSoftwareVersion"
		}

		public var aSoftwareVersion: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))SoftwareVersionResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aSoftwareVersion: '\(aSoftwareVersion)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func softwareVersion(log: UPnPService.MessageLog = .none) async throws -> SoftwareVersionResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SoftwareVersion"
				case response = "u:SoftwareVersionResponse"
			}

			var action: SoapAction?
			var response: SoftwareVersionResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "SoftwareVersion", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct SoftwareUpdateResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aAvailable = "aAvailable"
			case aSoftwareVersion = "aSoftwareVersion"
		}

		public var aAvailable: Bool
		public var aSoftwareVersion: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))SoftwareUpdateResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aAvailable: \(aAvailable == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aSoftwareVersion: '\(aSoftwareVersion)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func softwareUpdate(log: UPnPService.MessageLog = .none) async throws -> SoftwareUpdateResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SoftwareUpdate"
				case response = "u:SoftwareUpdateResponse"
			}

			var action: SoapAction?
			var response: SoftwareUpdateResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "SoftwareUpdate", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct DeviceInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aDeviceInfoXml = "aDeviceInfoXml"
		}

		public var aDeviceInfoXml: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))DeviceInfoResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aDeviceInfoXml: '\(aDeviceInfoXml)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func deviceInfo(log: UPnPService.MessageLog = .none) async throws -> DeviceInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:DeviceInfo"
				case response = "u:DeviceInfoResponse"
			}

			var action: SoapAction?
			var response: DeviceInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "DeviceInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct CoreBoardIdResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aCoreBoardId = "aCoreBoardId"
		}

		public var aCoreBoardId: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))CoreBoardIdResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aCoreBoardId: '\(aCoreBoardId)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func coreBoardId(log: UPnPService.MessageLog = .none) async throws -> CoreBoardIdResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:CoreBoardId"
				case response = "u:CoreBoardIdResponse"
			}

			var action: SoapAction?
			var response: CoreBoardIdResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "CoreBoardId", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension linncoukVolkano2Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case deviceInfo = "DeviceInfo"
			case ipAddressList = "IpAddressList"
			case macAddressList = "MacAddressList"
			case coreBoardId = "CoreBoardId"
		}

		public var deviceInfo: String?
		public var ipAddressList: String?
		public var macAddressList: String?
		public var coreBoardId: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))linncoukVolkano_2State {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))deviceInfo: '\(deviceInfo ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))ipAddressList: '\(ipAddressList ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))macAddressList: '\(macAddressList ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))coreBoardId: '\(coreBoardId ?? "nil")'")
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
			if let deviceInfo = property.deviceInfo {
				result.deviceInfo = deviceInfo
			}
			if let ipAddressList = property.ipAddressList {
				result.ipAddressList = ipAddressList
			}
			if let macAddressList = property.macAddressList {
				result.macAddressList = macAddressList
			}
			if let coreBoardId = property.coreBoardId {
				result.coreBoardId = coreBoardId
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
