//
//  Ads.swift
//  PodKolesami
//
//  Created by Другов Родион on 08.12.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import Foundation

struct Announcement: Decodable {
    var status: String?
    var data: [DetailedInformation]
}

struct DetailedInformation: Decodable {
    var id: String?
    var title: String?
    var image: String?
    var category: CategoryInTableView
    var description: String?
    var color: String?
    var user: String?
}

struct CategoryInTableView: Decodable {
    var id: String?
    var title: String?
}
