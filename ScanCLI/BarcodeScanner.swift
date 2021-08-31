//
//  BarcodeScanner.swift
//  ScanCLI
//
//  Created by Ayden Panhuyzen on 2021-08-29.
//

import Foundation
import Vision

class BarcodeScanner {
    func scan(fileInput: String) -> ScannedEntry {
        let url = URL(fileURLWithPath: fileInput)
        let result = ScannedEntry.ScanResult {
            let data = try Data(contentsOf: url)
            return try detectBarcodes(imageData: data)
        }

        return ScannedEntry(input: fileInput, url: url, result: result)
    }

    private func detectBarcodes(imageData: Data) throws -> [VNBarcodeObservation] {
        let request = VNDetectBarcodesRequest()

        let handler = VNImageRequestHandler(data: imageData)
        try handler.perform([request])

        return request.results as! [VNBarcodeObservation]
    }
}

struct ScannedEntry {
    typealias ScanResult = Result<[VNBarcodeObservation], Error>
    let input: String, url: URL, result: ScanResult
}
