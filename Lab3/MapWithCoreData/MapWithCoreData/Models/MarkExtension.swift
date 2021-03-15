//
//  MarkExtension.swift
//  MapWithCoreData
//
//  Created by Nursat on 24.02.2021.
//

import Foundation
import CoreData

extension Mark {
  static var newFetchRequest: NSFetchRequest<Mark> {
    let request: NSFetchRequest<Mark> = Mark.fetchRequest()
    request.returnsObjectsAsFaults = false
    request.sortDescriptors = []

    return request
  }
}
