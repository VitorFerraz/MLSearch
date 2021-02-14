//
//  JsonFromFile.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 14/02/21.
//

import Foundation
extension Decodable {
  static func parse(jsonFile: String) -> Self? {
    guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let output = try? JSONDecoder().decode(self, from: data)
        else {
      return nil
    }

    return output
  }
}
