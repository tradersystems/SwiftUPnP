import Foundation
import Combine
import XMLCoder
import os.log

public class linncoukConfiguration1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct ConfigurationXmlResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aConfigurationXml = "aConfigurationXml"
		}

		public var aConfigurationXml: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ConfigurationXmlResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aConfigurationXml: '\(aConfigurationXml)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func configurationXml(log: UPnPService.MessageLog = .none) async throws -> ConfigurationXmlResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ConfigurationXml"
				case response = "u:ConfigurationXmlResponse"
			}

			var action: SoapAction?
			var response: ConfigurationXmlResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ConfigurationXml", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ParameterXmlResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case aParameterXml = "aParameterXml"
		}

		public var aParameterXml: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ParameterXmlResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))aParameterXml: '\(aParameterXml)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func parameterXml(log: UPnPService.MessageLog = .none) async throws -> ParameterXmlResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ParameterXml"
				case response = "u:ParameterXmlResponse"
			}

			var action: SoapAction?
			var response: ParameterXmlResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ParameterXml", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func setParameter(aTarget: String, aName: String, aValue: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case aTarget = "aTarget"
				case aName = "aName"
				case aValue = "aValue"
			}

			@Attribute var urn: String
			public var aTarget: String
			public var aName: String
			public var aValue: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetParameter"
			}

			var action: SoapAction
		}
		try await post(action: "SetParameter", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), aTarget: aTarget, aName: aName, aValue: aValue))), log: log)
	}

}

// Event parser
extension linncoukConfiguration1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case configurationXml = "ConfigurationXml"
			case parameterXml = "ParameterXml"
		}

		public var configurationXml: String?
		public var parameterXml: String?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))linncouk-Configuration-1State {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))configurationXml: '\(configurationXml ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))parameterXml: '\(parameterXml ?? "nil")'")
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
			if let configurationXml = property.configurationXml {
				result.configurationXml = configurationXml
			}
			if let parameterXml = property.parameterXml {
				result.parameterXml = parameterXml
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
