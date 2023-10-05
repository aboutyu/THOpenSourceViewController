//
//  File.swift
//  
//
//  Created by 유태훈 on 2023/10/05.
//

import Foundation

open struct THLicensesKeyEntity {
    var name: String
    var license: THLicensesKey
    var licenseText: String?
    var year: String?
    var licenseName: String?
    
    init(name: String,
         license: THLicensesKey,
         licenseText: String? = nil,
         year: String? = nil,
         licenseName: String? = nil) {
        self.name = name
        self.license = license
        self.licenseText = licenseText
        self.year = year
        self.licenseName = licenseName
    }
    
    var yearToString: String {
        if let year = year { return year }
        
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.timeZone = .autoupdatingCurrent
        formatter.dateFormat = "yyyy"
        return formatter.string(from: Date())
    }
    
    var fullName: String {
        if let licenseName = licenseName { return licenseName }
        return name
    }
}

