//
//  GDLogger.swift
//  GDLogger
//
//  Created by Gene De Lisa on 02/10/17.
//  Copyright © 2017 genedelisa. All rights reserved.
//

import Foundation
import os.log


/// The logger. This is a wrapper for `OSLog`. It falls back to `NSLog` in some cases.
public struct GDLogger {
    
    private let logger: OSLog?
    
    /// Predefined subsystems. Extend these.
    public enum LogSubsystem: String {
        case `default`
        case bundle
        case core
        case db
        case net
        case media
        case io
        case model
        case view
        case controller
    }
    
    /// The Category. Extend these.
    public enum LogCategory: String {
        case general
        case params
        case paramsController
    }
    
    /// emitted before message in debug level
    public var debugPrefix = "😺😺😺 "
    /// emitted after message in debug level
    public var debugPostfix = " 😺😺😺"
    public var errorPrefix = "‼️😿‼️ "
    public var errorPostfix = " ‼️😿‼️"
    public var infoPrefix = "ℹ️😼ℹ️ "
    public var infoPostfix = " ℹ️😼ℹ️"
    public var faultPrefix = "🙀🙀‼️ "
    public var faultPostfix = " 🙀🙀‼️"
    public var msgSeparator = " ☞ "
    public var fileSeparator = " 🗄"
    public var lineSeparator = "➸"
    
    
    /// Create a new `GDLogger`.
    /// This is available only if on iOS 10 or greater or macOS 10.12 or later.
    ///
    /// - Parameters:
    ///   - category: The logging category
    ///   - subSystem: the logging subsystem
    public init(_ category: LogCategory = .general, subSystem: LogSubsystem = .bundle) {
        if subSystem == .bundle {
            if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
                logger = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: category.rawValue)
            } else {
                logger = nil
            }
        } else {
            if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
                logger = OSLog(subsystem: subSystem.rawValue, category: category.rawValue)
            } else {
                logger = nil
            }
        }
    }
    
    public func info(_ msg: StaticString, _ args: CVarArg, function: String = #function,
                     file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            if let logger = logger {
                os_log(msg, log: logger, type: .info, args)
            } else {
                os_log(msg, type: .info, args)
            }
        }
    }
    
    public func error(_ msg: StaticString, _ args: CVarArg, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            if let logger = logger {
                os_log(msg, log: logger, type: .error, args)
            } else {
                os_log(msg, type: .error, args)
            }
        }
    }
    
    public func debug(_ msg: StaticString, _ args: CVarArg, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            let message = format(msg, function: function, file: file, line: line)
            if let logger = logger {
                os_log("%{public}@", dso: dso, log: logger, type: .debug, message)
            } else {
                os_log("%{public}@", dso: dso, type: .debug, message)
            }
        }
    }
    
    public func fault(_ msg: StaticString, _ args: CVarArg, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            let message = format(msg, function: function, file: file, line: line)
            if let logger = logger {
                os_log("%{public}@", dso: dso, log: logger, type: .fault, message)
            } else {
                os_log("%{public}@", dso: dso, type: .fault, message)
            }
        }
        
    }
    
    public func debug(_ msg: String, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            let message = format(msg, function: function, file: file, line: line)
            if let logger = logger {
                os_log("%@%{public}@%@", dso: dso, log: logger, type: .debug, debugPrefix, message, debugPostfix)
            }
        } else {
            NSLog("%@", msg)
        }
    }
    
    public func error(_ msg: String, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            let message = format(msg, function: function, file: file, line: line)
            if let logger = logger {
                os_log("%@%{public}@%@", dso: dso, log: logger, type: .debug, errorPrefix, message, errorPostfix)
            }
        } else {
            NSLog("%@", msg)
        }
    }
    
    public func info(_ msg: String, function: String = #function,
                     file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            let message = format(msg, function: function, file: file, line: line)
            if let logger = logger {
                os_log("%@%{public}@%@", dso: dso, log: logger, type: .debug, infoPrefix, message, infoPostfix)
            }
        } else {
            NSLog("%@", msg)
        }
    }
    
    public func fault(_ msg: String, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            let message = format(msg, function: function, file: file, line: line)
            
            if let logger = logger {
                os_log("%@%{public}@%@", dso: dso, log: logger, type: .debug, faultPrefix, message, faultPostfix)
            }
        } else {
            NSLog("%@", msg)
        }
    }
    
    
    
    fileprivate func format(_ message: String, function: String, file: String, line: Int32) -> String {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        return "\(message)\(msgSeparator)\(function)\(fileSeparator)\(fileName)\(lineSeparator)\(line)"
    }
    
    fileprivate func format(_ message: StaticString, function: String, file: String, line: Int32) -> String {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
//        return "\(message) → \(function) ⋆ \(fileName) ):\(line)"
        return "\(message)\(msgSeparator)\(function)\(fileSeparator)\(fileName)\(lineSeparator)\(line)"
    }
    
    
}
