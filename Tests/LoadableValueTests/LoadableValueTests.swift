import XCTest
@testable import LoadableValue


enum SampleError: Error {
    case sampleError
}

extension SampleError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .sampleError:
            return "Cookie not found."
        }
    }
}

final class LoadableValueTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        var testVariable = LoadableValue<Int, Error>()

        guard case .waiting = testVariable else {
            XCTFail("Test Failed.")
            return
        }
        XCTAssertTrue(testVariable.isWaiting)
        XCTAssertEqual(testVariable.getData, nil)

        testVariable = .loading

        guard case .loading = testVariable else {
            XCTFail("Test Failed.")
            return
        }
        XCTAssertTrue(testVariable.isLoading)
        XCTAssertEqual(testVariable.getData, nil)

        testVariable = .failure(SampleError.sampleError)

        guard case .failure(SampleError.sampleError) = testVariable else {
            XCTFail("Test Failed.")
            return
        }
        XCTAssertTrue(testVariable.isFailure)
        XCTAssertEqual(testVariable.getData, nil)

        testVariable = .success(1)

        guard case .success(1) = testVariable else {
            XCTFail("Test Failed.")
            return
        }
        XCTAssertTrue(testVariable.isSuccess)
        XCTAssertEqual(testVariable.getData!, 1)
    }
}
