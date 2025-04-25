//
//  Enums.swift
//  
//
//  Created by Łukasz Dziedzic on 23/04/2025.
//

enum DeviceType: UInt32 {
    case coordinator = 0x00
    case router      = 0x01
    case endDevice   = 0x02
    case none        = 0x03
    var rawCValue: esp_zb_nwk_device_type_t {
        esp_zb_nwk_device_type_t(self.rawValue)
    }
}

enum RadioMode: UInt32 {
    case native = 0x0
    case UartRcp = 0x1
    var rawCValue: esp_zb_radio_mode_t {
        esp_zb_radio_mode_t(self.rawValue)
    }
}

enum HostConnectionMode: UInt32 {
    case none = 0x00
    case cli  = 0x01
    case rcp  = 0x02
    var rawCValue: esp_zb_host_connection_mode_t {
        esp_zb_host_connection_mode_t(self.rawValue) 
    }
}
