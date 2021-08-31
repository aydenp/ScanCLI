//
//  Protocol.swift
//  ScanCLI
//
//  Created by Ayden Panhuyzen on 2021-08-29.
//

import Foundation

protocol Outputting {
    /**
     Prints this mode's output to stdout.

     - throws: If there is an error that was not handled by the output (such as JSON, which will just null out a barcode), the implementer shall throw it here.
     - returns: Whether the operation was fully successful (i.e. for each image).
     */
    func printOutput(entries: [ScannedEntry]) throws -> Bool
}
