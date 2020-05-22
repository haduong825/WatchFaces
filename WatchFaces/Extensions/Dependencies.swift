//
//  Dependencies.swift
//  WatchFaces
//
//  Created by Hà Dương on 5/20/20.
//  Copyright © 2020 Hà Dương. All rights reserved.
//

import Foundation
import UIKit

enum Dependencies {
    struct Name {
        let rawValue: String
        static let `default` = Name(rawValue: "__default__")
    }
    
    final class Container {
        private var dependencies: [(key: Dependencies.Name, value: Any)] = []
        
        static let `default` =   Container()
        
        func register(_ dependency: Any, for key: Dependencies.Name = .default) {
            dependencies.append((key: key, value: dependency))
        }
        
        func resolve<T>(_ key: Dependencies.Name = .default) -> T {
            return (dependencies
                .filter { (dependencyTuple) -> Bool in dependencyTuple.key.rawValue == key.rawValue && dependencyTuple.value is T }
                .first)?.value as! T
        }
    }
    
    @propertyWrapper
    struct Inject<T> {
        private let dependencyName: Name
        private let container: Container
        var wrappedValue: T {
            get { container.resolve(dependencyName) }
        }
        init(_ dependencyName: Name = .default, on container: Container = .default) {
            self.dependencyName = dependencyName
            self.container = container
        }
    }
}
