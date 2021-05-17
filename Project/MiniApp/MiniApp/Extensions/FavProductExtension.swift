//
//  FavProductExtension.swift
//  MiniApp
//
//  Created by Nursat on 12.05.2021.
//

import Foundation
import CoreData

extension FavProduct {
  static var newFetchRequest: NSFetchRequest<FavProduct> {
    let request: NSFetchRequest<FavProduct> = FavProduct.fetchRequest()
    request.returnsObjectsAsFaults = false
    request.sortDescriptors = []

    return request
  }
}
