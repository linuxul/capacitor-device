import XCTest
@testable import DevicePlugin

class DeviceTests: XCTestCase {
    func testDiskSizesAreReported() throws {
        let implementation = CommunityDevice()

        let total = try XCTUnwrap(implementation.getTotalDiskSize())
        let free = try XCTUnwrap(implementation.getFreeDiskSize())

        XCTAssertGreaterThan(total, 0)
        XCTAssertGreaterThan(free, 0)
        XCTAssertLessThanOrEqual(free, total)
    }

    func testPluginIsBridgedUnderItsJavaScriptName() {
        let plugin = CommunityDevicePlugin()

        XCTAssertEqual(plugin.identifier, "CommunityDevicePlugin")
        XCTAssertEqual(plugin.jsName, "CommunityDevice")
        XCTAssertEqual(plugin.pluginMethods.map(\.name), ["getInfo"])
    }
}
