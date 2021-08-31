//
//  JSONOutputter.swift
//  ScanCLI
//
//  Created by Ayden Panhuyzen on 2021-08-29.
//

import Foundation

class JSONOutputter: Outputting {
    let encoder = JSONEncoder()

    func printOutput(entries: [ScannedEntry]) throws -> Bool {
        let output = CodableOutput.from(entries: entries)

        let data = try encoder.encode(output)
        print(String(data: data, encoding: .utf8)!)

        return !output.files.contains { !$0.value.success }
    }
}
