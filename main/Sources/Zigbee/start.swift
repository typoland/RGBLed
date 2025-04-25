//
//  ZigbeeHandler.swift
//  
//
//  Created by Łukasz Dziedzic on 21/04/2025.
//

enum ZigbeeError:Swift.Error {
    case nvsFlashInitFailed(String)
    case platformConfigFailed(String)
    case cantGetMessageFromPointer
    case deviceRegisterFailed(String)
    case manufacturerInfoFailed(String)
    var description: String {
        switch self {
        case .nvsFlashInitFailed(let string):
            return "NVS Flash Failed: \(string)"
        case .platformConfigFailed(let string): 
            return "Start Failed: \(string)"
        case .manufacturerInfoFailed(let string): 
            return "Manufacturer Info Failed: \(string)"
        case .deviceRegisterFailed(let string): 
            return "Device Register Failed: \(string)"
        case .cantGetMessageFromPointer:
            return "Cant get message from pointer"
        }
    }
}

func start() throws (ZigbeeError) {
        print ("\(#fileID) \(#function) Start")
        switch runEsp({nvs_flash_init()}) {
        case .success: break
        case .failure(let err): throw .nvsFlashInitFailed(err)
        }
        print ("\(#fileID) \(#function) NVS Flash inited")
        
    var config = PlatformConfig.dimmableLight // .native, .none
        switch runEsp({esp_zb_platform_config(&config)}) {
        case .success: break
        case .failure(let err): throw .platformConfigFailed(err)
        }
        print ("\(#fileID) \(#function) Platform configured")
    
        xTaskCreate(zigbeeTask, "Zigbee_main", 4096, nil, 5, nil)
        print ("\(#fileID) \(#function) Zigbee started")
    }

