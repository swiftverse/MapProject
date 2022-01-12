//
//  FileManager_Extension.swift
//  MapProject
//
//  Created by Amit Shrivastava on 11/01/22.
//

import Foundation

extension FileManager {
    static var getDocumentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
