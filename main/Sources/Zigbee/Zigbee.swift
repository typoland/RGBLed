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
        print ("\(#function) Start")
        switch runEsp({nvs_flash_init()}) {
        case .success: break
        case .failure(let err): throw .startFailed(err)
        }
        print ("\(#function) NVS Flash inited")
        
        var config = PlatformConfig () // .native, .none
        switch runEsp({esp_zb_platform_config(&config)}) {
        case .success: break
        case .failure(let err): throw .startFailed(err)
        }
        print ("\(#function) Platform configurated")
        xTaskCreate(zigbeeTask, "Zigbee_main", 4096, nil, 5, nil)
        print ("\(#function) Zigbee started")
    }
}
