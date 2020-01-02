//
//  Сategory.swift
//  PodKolesami
//
//  Created by Другов Родион on 06.12.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import Foundation

struct CategoryInformation: Decodable {
    var status: String?
    var data: [Category]
}

struct Category: Decodable {
    var id: String?
    var title: String?
    var image: String?
}
