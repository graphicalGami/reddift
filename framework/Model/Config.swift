//
//  Config.swift
//  reddift
//
//  Created by sonson on 2015/04/13.
//  Copyright (c) 2015年 sonson. All rights reserved.
//

import Foundation

/**
Class to manage parameters of reddift.
This class is used as singleton model
*/
public final class Config {
	/// Application verison, be updated by Info.plist later.
    public let version: String
	/// Bundle identifier, be updated by Info.plist later.
    public let bundleIdentifier: String
	/// Developer's reddit user name
    public var developerName: String {
        loadFromJSONIfNeeded()
        return _developerName
    }
	/// OAuth redirect URL you register
    public var redirectURI: String {
        loadFromJSONIfNeeded()
        return _redirectURI
    }
	/// Application ID
    public var clientID: String {
        loadFromJSONIfNeeded()
        return _clientID
    }

    private var _developerName = ""
    private var _redirectURI = ""
    private var _clientID = ""
    private var didLoadFromJSON = false
    private var clientIDOverridden = false
    
    /**
    Singleton model.
    */
    public static let sharedInstance = Config()
    
    /**
    Returns User-Agent for API
    */
    public var userAgent: String {
        return "ios:" + bundleIdentifier + ":v" + version + "(by /u/" + developerName + ")"
    }
    
    /**
    Returns scheme of redirect URI.
    */
    public var redirectURIScheme: String {
        if let scheme = URL(string: redirectURI)?.scheme {
            return scheme
        } else {
            return ""
        }
    }

    /**
    Sets the OAuth client ID after initialization without restarting the app.
    Values set here take precedence over ``reddift_config.json`` until ``reinitialize(reloadFromJSON:)`` reloads from disk.
    */
    public func setClientID(_ clientID: String) {
        _clientID = clientID
        clientIDOverridden = true
    }

    /**
    Updates configuration after initialization.

    - Parameters:
      - clientID: When non-nil, replaces the current client ID (same as ``setClientID(_:)``).
      - reloadFromJSON: When true, re-reads ``reddift_config.json`` and applies its values (except a previously set client ID is kept unless you pass ``clientID``).
    */
    public func reinitialize(clientID: String? = nil, reloadFromJSON: Bool = false) {
        if reloadFromJSON {
            clientIDOverridden = false
            didLoadFromJSON = false
            loadFromJSONIfNeeded()
        }
        if let clientID = clientID {
            setClientID(clientID)
        }
    }
	
    private init() {
        version =  Bundle.infoValueInMainBundle(for: "CFBundleShortVersionString") as? String ?? "1.0"
        bundleIdentifier = Bundle.infoValueInMainBundle(for: "CFBundleIdentifier") as? String ?? ""
    }

    private func loadFromJSONIfNeeded() {
        guard !didLoadFromJSON else { return }
        didLoadFromJSON = true

        guard let path = Bundle.module.path(forResource: "reddift_config", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return
        }

        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary else {
                return
            }
            if let developerName = json["DeveloperName"] as? String {
                _developerName = developerName
            }
            if let redirectURI = json["redirect_uri"] as? String {
                _redirectURI = redirectURI
            }
            if !clientIDOverridden, let clientID = json["client_id"] as? String {
                _clientID = clientID
            }
        } catch {
        }
    }
}
