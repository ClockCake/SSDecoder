//
//  SSDecoderTests.swift
//  SSDecoderTests
//
//  Created by hyd on 2024/2/1.
//

import XCTest
@testable import SSDecoder // 替换为您的项目名称

class ViewControllerTests: XCTestCase {

    var viewController: ViewController!

    override func setUpWithError() throws {
        // 在这里初始化ViewController
        viewController = ViewController()
    }

    override func tearDownWithError() throws {
        // 在这里释放ViewController
        viewController = nil
    }

    func testSSDecoder() throws {
        // 测试SSDecoder方法
        let base64String = "SGVsbG8gV29ybGQh" // 这是"Hello World!"的Base64编码
        let decodedString = try viewController.SSDecoder(base64EncodedString: base64String)
        XCTAssertEqual(decodedString, "Hello World!", "SSDecoder 方法应该解码为 'Hello World!'")
    }

    func testEncodeArrayToBase64() {
        // 测试encodeArrayToBase64方法
        let strings = ["Hello", "World"]
        let base64String = viewController.encodeArrayToBase64(strings: strings)
        let expectedBase64String = "SGVsbG8KV29ybGQ=" // 这是"Hello\nWorld"的Base64编码
        XCTAssertEqual(base64String, expectedBase64String, "encodeArrayToBase64 方法应该正确编码数组")
    }

    func testProcessString() {
        // 测试processString方法
        let inputString = "trojan://example@server:port?param=value#日本"
        let processedStrings = viewController.processString(inputString)
        let expectedOutput = ["trojan://example@server:port?param=value#日本"]
        XCTAssertEqual(processedStrings, expectedOutput, "processString 方法应该处理字符串并返回期望的数组")
    }

    // ... 可以根据需要添加更多测试
}

