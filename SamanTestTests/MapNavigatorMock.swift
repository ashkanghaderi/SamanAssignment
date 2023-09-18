//
//  MapNavigatorMock.swift
//  SamanTestTests
//
//  Created by Ashkan Ghaderi on 2022-02-18.
//

@testable import SamanTest
import Foundation

class MapNavigatorMock: MapPointNavigatorProtocol {

  var toAirPorts_Called = false
  var toAirPorts_ReceivedArguments: [AirPortModel]?

  func toAirPorts(model: [AirPortModel]) {
      toAirPorts_Called = true
      toAirPorts_ReceivedArguments = model
  }
}
