//
//  HumanReadableOutputter.swift
//  ScanCLI
//
//  Created by Ayden Panhuyzen on 2021-08-29.
//

import Foundation
import Vision

class HumanReadableOutputter: Outputting {
    func printOutput(entries: [ScannedEntry]) -> Bool {
        var fullSuccess = true
        for entry in entries {
            print("\(entry.input):")
            do {
                let observations = try entry.result.get()
                guard !observations.isEmpty else { throw HumanReadableOutputModeError.noBarcodes }
                print(observations.map { "- \($0.humanReadableDescription)" }.joined(separator: "\n"))
            } catch {
                // Handle this error ourselves so we can continue onto the next file after
                print("Error: \(error.localizedDescription)")
                fullSuccess = false
            }
        }
        return fullSuccess
    }
}

private extension VNBarcodeObservation {
    var humanReadableDescription: String {
        return "\(symbology.rawValue): \(payloadStringValue ?? "(null)")"
    }
}

private enum HumanReadableOutputModeError: Error, LocalizedError {
    case noBarcodes

    var errorDescription: String? {
        return "No barcodes found."
    }
}
