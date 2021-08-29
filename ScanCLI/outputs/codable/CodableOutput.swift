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

    struct ScannedFile: Encodable {
        let success: Bool, filepath: String, barcodes: [Barcode]?

        struct Barcode: Encodable {
            let type: String, data: String?

            static func from(observation: VNBarcodeObservation) -> Barcode {
                return .init(type: observation.symbology.rawValue, data: observation.payloadStringValue)
            }
        }

        static func from(entry: ScannedEntry) -> ScannedFile {
            let observations = try? entry.result.get()
            return .init(success: observations != nil, filepath: entry.url.path, barcodes: observations?.map { Barcode.from(observation: $0) })
        }
    }

    static func from(entries: [ScannedEntry]) -> CodableOutput {
        let files = Dictionary(uniqueKeysWithValues: entries.map { ($0.input, ScannedFile.from(entry: $0)) })
        return .init(files: files)
    }
}
