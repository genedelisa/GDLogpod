//
//  GDLog.swift
//  GDLog
//
//  Created by Gene De Lisa on 23/10/15.
//  Copyright © 2017 genedelisa. All rights reserved.
//

import PackageDescription


let package = Package(
    name: "GDLog",
    products: [
        .library(name: "GDLog", targets: ["GDLog"]),
        ],
    targets: [
        .target(
            name: "GDLog",
            dependencies: []),
        .testTarget(
            name: "GDLogTests",
            dependencies: ["GDLog"]),
        ]
)
