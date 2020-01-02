//
//  detailAnnouncement.swift
//  PodKolesami
//
//  Created by Другов Родион on 18.12.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import Foundation

struct DetailAnnoucement: Decodable {
    var status: String?
    var data: AnnoucementOnVC
}

struct AnnoucementOnVC: Decodable {
    var id: String?
    var title: String?
    var image: String?
    var gallery: [String]?
    var params: [[String: String]]?
    var category: CategoryOnVC
    var description: String?
    var color: String?
    var user: String?
}

struct CategoryOnVC: Decodable {
    var id: String?
    var title: String?
}


