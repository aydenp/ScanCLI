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

let outputter: Outputting
if CommandLine.arguments.contains("--json") {
    outputter = JSONOutputter()
} else if CommandLine.arguments.contains("--plist") {
    outputter = PropertyListOutputter()
} else {
    outputter = HumanReadableOutputter()
}

do {
    if !(try outputter.printOutput(entries: entries)) {
        // Exit with code 1 if the output mode reported an partial issue but still printed
        exit(1)
    }
} catch let error {
    print("Error: \(error.localizedDescription)")
    exit(1)
}
