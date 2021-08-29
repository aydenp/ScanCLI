//
//  JSONOutputMode.swift
//  ScanCLI
//
//  Created by Ayden Panhuyzen on 2021-08-29.
//

import Foundation

class JSONOutputMode: OutputModeRepresentable {
    func printOutput(entries: [ScannedEntry]) -> Bool {
        let output = CodableOutput.from(entries: entries)

        let encoder = JSONEncoder()
        if let data = try? encoder.encode(output), let str = String(data: data, encoding: .utf8) {
            print(str)
        }

        return !output.files.contains { !$0.value.success }
    }
}
