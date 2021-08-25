//
//  main.swift
//  SwiftPlist
//
//  Created by Justin Bui on 8/24/21.
//

import Foundation

// https://gist.github.com/cprovatas/5c9f51813bc784ef1d7fcbfb89de74fe
extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}

func converPlist(path: String, format: String) {
    
}

func Help()
{
    print("SwiftPlist by @slyd0g")
    print("Usage:")
    print("-h || -help                     | Print help menu")
    print("-p || -path /path/to/test.plist | Path to plist file ")
    print("-c || -convert                  | Convert plist to specified type: 'json', 'xml', or 'binary'")
    print()
    print("Example:")
    print("     Read plist data: SwiftPlist -p /path/to/slyd0g.plist")
    print("     Convert plist to binary: SwiftPlist -p /path/to/peaches.plist -c binary")
}

if CommandLine.arguments.count == 1 {
    Help()
    exit(0)
}
else {
    for argument in CommandLine.arguments {
        if (argument.contains("-h") || argument.contains("-help")) {
            Help()
            exit(0)
        }
        else if (argument.contains("-p") || argument.contains("-path")) {
            do {
                var path = CommandLine.arguments[2]
                if path.contains("~") {
                    path = NSString(string: path).expandingTildeInPath
                }
                print("Reading in \(path)...")
                let fileURL = URL(fileURLWithPath: path)
                let fileContents = try Data(contentsOf: fileURL)
                
                let headerBytes = fileContents.subdata(in: 0 ..< 1)
                let headerString = String(bytes: headerBytes, encoding: .utf8)
                
                switch headerString {
                case "<":
                    let xml = FileManager.default.contents(atPath: path)
                    let plist = try PropertyListSerialization.propertyList(from: xml!, options: .mutableContainersAndLeaves, format: nil)
                    print(plist)
                    
                    if CommandLine.arguments.contains("-c") || CommandLine.arguments.contains("-convert") {
                        let plistFormat = CommandLine.arguments[4]
                        let outputPath = FileManager.default.currentDirectoryPath + "/output.plist"
                        let outputURL = URL(fileURLWithPath: outputPath)
                        print("Converting \(path) to \(plistFormat) format...")
                        print("Converted file will be in your current directory and named 'output.plist'")
                        
                        switch plistFormat {
                        case "binary":
                            do {
                                let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .binary, options: 0)
                                try data.write(to: outputURL)
                            }
                            catch {
                                print("Exception caught: \(error)")
                            }
                        case "xml":
                            do {
                                let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
                                try data.write(to: outputURL)
                            }
                            catch {
                                print("Exception caught: \(error)")
                            }
                        case "json":
                            print("JSON format currently unsupported :(")
                        default:
                            print("Failed to convert because of unsupported plist type, please use 'json', 'xml', or 'binary'")
                        }
                    }
                case "{":
                    let json = try Data(contentsOf: URL(fileURLWithPath: path))
                    print(json.prettyPrintedJSONString ?? "")
                case "b":
                    let binary = FileManager.default.contents(atPath: path)
                    let plist = try PropertyListSerialization.propertyList(from: binary!, options: .mutableContainersAndLeaves, format: nil)
                    print(plist)
                    if CommandLine.arguments.contains("-c") || CommandLine.arguments.contains("-convert") {
                        let plistFormat = CommandLine.arguments[4]
                        let outputPath = FileManager.default.currentDirectoryPath + "/output.plist"
                        let outputURL = URL(fileURLWithPath: outputPath)
                        print("Converting \(path) to \(plistFormat) format...")
                        print("Converted file will be in your current directory and named 'output.plist'")
                        
                        switch plistFormat {
                        case "binary":
                            do {
                                let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .binary, options: 0)
                                try data.write(to: outputURL)
                            }
                            catch {
                                print("Exception caught: \(error)")
                            }
                        case "xml":
                            do {
                                let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
                                try data.write(to: outputURL)
                            }
                            catch {
                                print("Exception caught: \(error)")
                            }
                        case "json":
                            print("JSON format currently unsupported :(")
                        default:
                            print("Failed to convert because of unsupported plist type, please use 'json', 'xml', or 'binary'")
                        }
                    }
                default:
                    print("Error: Couldn't determine plist format")
                }
            }
            catch {
                print("Exception caught: \(error)")
            }
        }
    }
}
