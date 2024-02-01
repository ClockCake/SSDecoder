//
//  ViewController.swift
//  SSDecoder
//
//  Created by hyd on 2023/11/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://sub.getlitchi.com/api/v1/client/subscribe?token=2222eaa873267540415effc4dc97f521") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print(error ?? "Unknown error")
                    return
                }

                if let body = String(data: data, encoding: .utf8) {
                    do {
                        let decodedString = try self.SSDecoder(base64EncodedString: body)
                        let filteredStrings = self.processString(decodedString)
                        let base64EncodedStrings = self.encodeArrayToBase64(strings: filteredStrings)
                        print(base64EncodedStrings)

                        for string in filteredStrings {
                            print(string)
                        }
                    } catch DecodingError.invalidBase64 {
                        print("Invalid Base64 string")
                    } catch DecodingError.failedToDecode {
                        print("Failed to decode")
                    } catch {
                        print("An unknown error occurred")
                    }
                }
            }

            task.resume()
        }



    }
    ///解码
    func SSDecoder(base64EncodedString: String) throws -> String {
        guard let data = Data(base64Encoded: base64EncodedString) else {
            throw DecodingError.invalidBase64
        }
        guard let decodedString = String(data: data, encoding: .utf8) else {
            throw DecodingError.failedToDecode
        }
        return decodedString
    }
    ///编码
    func encodeArrayToBase64(strings: [String]) -> String {
        let combinedString = strings.joined(separator: "\n")
        if let data = combinedString.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return combinedString
    }

    enum DecodingError: Error {
        case invalidBase64
        case failedToDecode
    }


    func processString(_ inputString: String) -> [String] {
        var strings = inputString.components(separatedBy: "\n")
        // 添加新的字符串
        strings.insert("trojan://daydream@azure.clockcat.site:42143?allowInsecure=0&peer=azure.clockcat.site&sni=azure.clockcat.site#日本Microsoft Azure", at: 0)
        strings.insert("trojan://daydream@bandwagon.clockcat.site:42143?allowInsecure=0&peer=bandwagon.clockcat.site&sni=bandwagon.clockcat.site#美国GIA", at: 0)
        return strings.compactMap { string in

            // 分割字符串并处理URL编码部分
            var parts = string.split(separator: "#", maxSplits: 1, omittingEmptySubsequences: true)

            guard parts.count == 2 else { return string }

            var decodedPart = parts[1].removingPercentEncoding ?? String(parts[1])
            
            // 检查并舍弃包含特定国家名的字符串
//            if decodedPart.contains("土耳其") || decodedPart.contains("法国") {
//                return nil
//            }

            // 移除特定的字符串
            decodedPart = decodedPart.replacingOccurrences(of: "Base", with: "")
            decodedPart = decodedPart.replacingOccurrences(of: "Plus", with: "")
            decodedPart = decodedPart.replacingOccurrences(of: "x1.5", with: "")

            // 将 IPLC(UDPN) 替换为 Premium
            decodedPart = decodedPart.replacingOccurrences(of: "IPLC(UDPN)", with: "Premium")

            return "\(parts[0])#\(decodedPart)"
        }
        .sorted(by: { lhs, rhs in
            // 提取国家名称并进行比较
            let countryNameLHS = lhs.components(separatedBy: "#").last ?? ""
            let countryNameRHS = rhs.components(separatedBy: "#").last ?? ""
            return countryNameLHS > countryNameRHS
        })
    }




}

