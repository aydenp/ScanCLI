//
//  CodableOutput.swift
//  ScanCLI
//
//  Created by Ayden Panhuyzen on 2021-08-29.
//

import Foundation
import Vision

struct CodableOutput: Encodable {
    let files: [String: ScannedFile]

    static func from(entries: [ScannedEntry]) -> CodableOutput {
        let files = Dictionary(uniqueKeysWithValues: entries.map { ($0.input, ScannedFile.from(entry: $0)) })
        return .init(files: files)
    }
}

// CodableOutput.ScannedFile
extension CodableOutput {
    struct ScannedFile: Encodable {
        let success: Bool, filepath: String, barcodes: [Barcode]?, errorMessage: String?

        init(filepath: String, barcodes: [CodableOutput.ScannedFile.Barcode]) {
            self.success = true
            self.filepath = filepath
            self.barcodes = barcodes
            self.errorMessage = nil
        }

        init(filepath: String, errorMessage: String?) {
            self.success = false
            self.filepath = filepath
            self.barcodes = nil
            self.errorMessage = errorMessage
        }

        static func from(entry: ScannedEntry) -> ScannedFile {
            do {
                let observations = try entry.result.get()
                return .init(filepath: entry.url.path, barcodes: observations.map { Barcode.from(observation: $0) })
            } catch let error {
                return .init(filepath: entry.url.path, errorMessage: error.localizedDescription)
            }
        }

        enum CodingKeys: String, CodingKey {
            case success, filepath, barcodes, errorMessage = "error"
        }
    }
}

// CodableOutput.ScannedFile.Barcode
extension CodableOutput.ScannedFile {
    struct Barcode: Encodable {
        let type: String, data: String?

        static func from(observation: VNBarcodeObservation) -> Barcode {
            return .init(type: observation.symbology.rawValue, data: observation.payloadStringValue)
        }
    }
}
