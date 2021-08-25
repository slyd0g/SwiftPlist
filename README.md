# SwiftPlist

![Help](https://raw.githubusercontent.com/slyd0g/SwiftPlist/main/example.png)

![Output](https://raw.githubusercontent.com/slyd0g/SwiftPlist/main/example2.png)

## Description

This tool is a partial rewrite of the `plutil` utility on macOS. It allows you to view property list (plist) files in any format (xml, json, binary). Additionally, it allows for conversion betweeen XML and binary plist files.

## Usage
- View contents of `binary.plist` file in human-readable format
    - ```./SwiftPlist -path binary.plist```
- View contents of `xml.plist` file in human-readable format and convert it to binary format
    - ```./SwiftPlist -path xml.plist -c binary```

## To-Do
- Converting to and from JSON plists
- Modify/insert/delete entries

## References
- https://scriptingosx.com/2016/11/editing-property-lists/
- https://developer.apple.com/documentation/foundation/propertylistserialization
