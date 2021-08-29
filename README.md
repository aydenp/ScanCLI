#  `scan` CLI

A quick CLI for scanning barcodes from images on Apple platforms using the Vision framework.

## Usage

`scan [files]`

### Additional Arguments

- `--json`: Print results in JSON for parsing.
- `--plist`: Print results in an XML property list for parsing.

## Example:

**Input:** `scan image.jpg`

**Output:** 
```
-- image.jpeg --
- VNBarcodeSymbologyAztec: Hello world!
```

---

**Input:** `scan --json image.jpg`

**Output:** 
```json
{"files":{"image.jpg":{"success":true,"filepath":"\/Users\/aydenp\/Desktop\/image.jpg","barcodes":[{"type":"VNBarcodeSymbologyAztec","data":"Hello world!"}]}}}
```

The same schema is used for plist output.
