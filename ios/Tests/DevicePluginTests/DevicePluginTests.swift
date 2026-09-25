import XCTest
import Capacitor
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
        XCTAssertEqual(plugin.pluginMethods.map(\.returnType), [.promise])
    }

    func testGetInfoResolvesWithTheDiskSizes() throws {
        var data: PluginCallResultData?
        // getInfo is synchronous: it answers the call before returning.
        CommunityDevicePlugin().getInfo(CAPPluginCall(callbackId: "test", methodName: "getInfo", options: [:], success: { result, _ in
            data = result.data
        }, error: { _ in
            XCTFail("getInfo must not reject")
        }))

        let info = try XCTUnwrap(data)
        let total = try XCTUnwrap(info["diskTotal"] as? Int64)
        XCTAssertGreaterThan(total, 0)
        XCTAssertEqual(info["realDiskTotal"] as? Int64, total)
        XCTAssertLessThanOrEqual(try XCTUnwrap(info["diskFree"] as? Int64), total)
        XCTAssertNotNil(info["realDiskFree"] as? Int64)
    }
}
