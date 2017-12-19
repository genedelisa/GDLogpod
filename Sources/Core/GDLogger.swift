//
//  GDLogger.swift
//  GDLogger
//
//  Created by Gene De Lisa on 02/10/17.
//  Copyright © 2017 genedelisa. All rights reserved.
//

import Foundation
import os.log


/// This is a façade for Apple's Unified Logging `OSLog`.
/// It falls back to `NSLog` in some cases.
public struct GDLogger {
    
    /// the system logger
    public var logger: OSLog?
    
    /// Predefined subsystems.
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
    
    /// The Category.
    public enum LogCategory: String {
        case general
        case params
        case paramsController
    }
    
    /// emitted before message in debug level
    public var debugPrefix = "😺😺😺 "
    /// emitted after message in debug level
    public var debugPostfix = " 😺😺😺"
    
    /// emitted before message in error level
    public var errorPrefix = "‼️😿‼️ "
    /// emitted after message in error level
    public var errorPostfix = " ‼️😿‼️"
    
    /// emitted before message in info level
    public var infoPrefix = "ℹ️😼ℹ️ "
    /// emitted after message in info level
    public var infoPostfix = " ℹ️😼ℹ️"
    
    /// emitted before message in fault level
    public var faultPrefix = "🙀🙀‼️ "
    /// emitted after message in fault level
    public var faultPostfix = " 🙀🙀‼️"
    
    /// message format separator
    public var msgSeparator = " ☞ "
    public var fileSeparator = " 🗄"
    public var lineSeparator = "➸"
    //2017-12-18 15:54:03.611598-0500 SlowItDown[31758:2620634] [general] 😺😺😺 authorized ☞ checkMediaLibraryPermission() 🗄MediaLibraryController.swift➸121 😺😺😺
    
    
   
    
    /// Init that actually creates the `OSLog` instance. Or not.
    ///
    /// - Parameters:
    ///   - subsystem: an optional subsystem. The bundle if not specified
    ///   - category: the category to use
    public init(_ subsystem: String? = nil, category: String ) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            if let subsystem = subsystem {
                logger = OSLog(subsystem: subsystem, category: category)
            } else {
                logger = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: category)
            }
        } else {
            logger = nil
        }

    }
    
    /// Init with specified predefined subsystem and category
    ///
    /// - Parameters:
    ///   - subsystem: a subsystem predefined in `LogSubsystem`
    ///   - category: a category predefined in `LogCategory`
    public init(_ subsystem: LogSubsystem, category: LogCategory = .general ) {
        
        if subsystem == .bundle {
            self.init(Bundle.main.bundleIdentifier!, category: category.rawValue)
        } else {
            self.init(subsystem.rawValue, category: category.rawValue)
        }
    }

    
    /// Default init. Called with inited with no args
    ///
    /// - Parameters:
    ///   - subsystem: the bundle if not specified
    ///   - category: general if not specified
    public init(_ subsystem: String? = nil, category: LogCategory = .general ) {
        
        if let subsystem = subsystem {
            self.init(subsystem, category: category.rawValue)
        } else {
            self.init(Bundle.main.bundleIdentifier!, category: category.rawValue)
        }
    }
    
    
    /// Log a Static String with Info level.
    ///
    /// - Parameters:
    ///   - msg: a Static String. No interpolation
    ///   - args: the arguments to pass to the static string
    ///   - function: defaults to function name
    ///   - file: defaults to filename
    ///   - line: defaults to line where this was called
    ///   - dso: dynamic shared objct. the currently loaded .dylib or .so
    /// - requires: iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0
    
    public func info(_ msg: StaticString, _ args: CVarArg, function: String = #function,
                     file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            logMessage(msg, .info, function, file, line, dso)
        }
    }
    
    
    public func error(_ msg: StaticString, _ args: CVarArg, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            logMessage(msg, .error, function, file, line, dso)
        }
    }
    
    public func debug(_ msg: StaticString, _ args: CVarArg, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            logMessage(msg, .debug, function, file, line, dso)
        }
    }
    
    public func fault(_ msg: StaticString, _ args: CVarArg, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            logMessage(msg, .fault, function, file, line, dso)
        }
        
    }
    
    
    fileprivate func logMessage(_ msg: StaticString, _ logType: OSLogType, _ function: String, _ file: String, _ line: Int32, _ dso: UnsafeRawPointer?) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            let message = format(msg, function: function, file: file, line: line)
            if let logger = logger {
                os_log("%{public}@", dso: dso, log: logger, type: logType, message)
            } else {
                os_log("%{public}@", dso: dso, type: logType, message)
            }
        }
    }
    
    
    
    // Strings as the message. Interpolation possible.
    
    fileprivate func logMessage(_ msg: String, _ prefix: String, _ postfix: String, _ logType: OSLogType, _ function: String, _ file: String, _ line: Int32, _ dso: UnsafeRawPointer?) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            let message = format(msg, function: function, file: file, line: line)
            if let logger = logger {
                if let dso = dso {
                    os_log("%@%{public}@%@", dso: dso, log: logger, type: logType, prefix, message, postfix)
                } else {
                    os_log("%@%{public}@%@", log: logger, type: logType, prefix, message, postfix)
                }
            }
        } else {
            NSLog("%@", msg)
        }
    }
    
    public func debug(_ msg: String, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            logMessage(msg, debugPrefix, debugPostfix, .debug, function, file, line, dso)
        }
    }
    
    public func error(_ msg: String, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            logMessage(msg, errorPrefix, errorPostfix, .error, function, file, line, dso)
        }
        
    }
    
    public func info(_ msg: String, function: String = #function,
                     file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            logMessage(msg, infoPrefix, infoPostfix, .info, function, file, line, dso)
        }
        
    }
    
    public func fault(_ msg: String, function: String = #function,
                      file: String = #file, line: Int32 = #line, dso: UnsafeRawPointer? = #dsohandle) {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOSApplicationExtension 3.0, *) {
            logMessage(msg, faultPrefix, faultPostfix, .fault, function, file, line, dso)
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
