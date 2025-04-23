//
//  ZigbeeHandler.swift
//  
//
//  Created by Łukasz Dziedzic on 21/04/2025.
//
typealias ZigbeeAppSignal = esp_zb_app_signal_t
class Zigbee {
    
    enum Error: Swift.Error {
        case startFailed(String)
    }
    
    static func start() throws (Error) {
        switch runEsp({nvs_flash_init()}) {
        case .success: break
        case .failure(let err): throw .startFailed(err)
        }
        
        var config = PlatformConfig () // .native, .none
        
        switch runEsp({esp_zb_platform_config(&config)}) {
        case .success: break
        case .failure(let err): throw .startFailed(err)
        }

        xTaskCreate(zigbeeTask, "Zigbee_main", 4096, nil, 5, nil)
        print ("Zigbee started")
    }
}
