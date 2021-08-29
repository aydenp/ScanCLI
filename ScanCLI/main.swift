//
//  main.swift
//  ScanCLI
//
//  Created by Ayden Panhuyzen on 2021-08-29.
//

import Foundation
import Vision

let files = Set(CommandLine.arguments.dropFirst().filter { !$0.starts(with: "--") })
guard !files.isEmpty else {
    print("Error: No files specified.")
    exit(1)
}

let scanner = BarcodeScanner()
let entries = files.map { scanner.scan(fileInput: $0) }

let outputMode: OutputModeRepresentable
if CommandLine.arguments.contains("--json") {
    outputMode = JSONOutputMode()
} else if CommandLine.arguments.contains("--plist") {
    outputMode = PlistOutputMode()
} else {
    outputMode = HumanReadableOutputMode()
}

if !outputMode.printOutput(entries: entries) {
    // Exit with code 1 if the output mode reported an issue printing
    exit(1)
}
