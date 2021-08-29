//
//  Protocol.swift
//  ScanCLI
//
//  Created by Ayden Panhuyzen on 2021-08-29.
//

import Foundation

protocol OutputModeRepresentable {
    /**
     Prints this mode's output to stdout.

     - returns: Whether the operation was fully successful (i.e. for each image).
     */
    func printOutput(entries: [ScannedEntry]) -> Bool
}
