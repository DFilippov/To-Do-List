//
//  String+Extension.swift
//  To Do List
//
//  Created by Ayu Filippova on 12/08/2019.
//  Copyright © 2019 Dmitry Filippov. All rights reserved.
//

extension String {
    var capitalizedWithSpaces: String {
        let withSpaces = reduce("") { result, character in
            character.isUppercase ? "\(result) \(character)" : "\(result)\(character)"
        }
    return withSpaces.capitalized
    }
}
