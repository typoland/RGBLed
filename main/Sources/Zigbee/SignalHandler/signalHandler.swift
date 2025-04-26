func checkComitioning(_ mode: ComissionigMode, after ms: UInt32 = 1000) {
    let mode = mode.rawValue
    esp_zb_scheduler_alarm( {mask in esp_zb_bdb_start_top_level_commissioning(mask)}, mode, ms)
}

func topLevelComitioning(_ mask: ComissionigMode) -> ESPError  {
    runEsp {esp_zb_bdb_start_top_level_commissioning(mask.rawValue)}
}
enum LightDriverError: Error { case notInited }

var ledStrip = try! LedStrip(gpioNr: 8, maxLeds: 1)
func lightDriver() throws (LightDriverError) {
    var isInited = false
    if !isInited {
        ledStrip.setPower(true)
        ledStrip.setPixel(index: 0, color: RGBColor(r: 30, g: 20, b: 3))
        isInited = true
        return
    }
    throw .notInited
}

@_cdecl("esp_zb_app_signal_handler")
public func signalHandler(_ signal: UnsafeMutablePointer<esp_zb_app_signal_t>?) {
    
    guard let signal = signal else { return }
    
    
    
    let p_sg_p = signal.pointee.p_app_signal
    let errStatus = signal.pointee.esp_err_status
    let sigType = p_sg_p?.pointee ?? 0  // esp_zb_app_signal_type_t
    let errName = String(cString: esp_err_to_name(errStatus))
    
    // Prepare optional parameter pointers
//    var devAnnceParams: UnsafeMutablePointer<esp_zb_zdo_signal_device_annce_params_t>? = nil
//    var leaveIndParams: UnsafeMutablePointer<esp_zb_zdo_signal_leave_indication_params_t>? = nil
    

    
    
    print("🔁 Zigbee signal received: type=\(sigType), status=\(errName)")
    guard let signalType = AppSignalType(rawValue: sigType) else {
        print ("no signal type: \(sigType)")
        return}
    
    switch (signalType) {
    case .skipStartup: 
        
        print ("\t#️⃣😍 Initialize Zigbee stack...", terminator: "")
        guard .success == topLevelComitioning(.initialization)
        else {print ("❌ Initialize Zigbee stack failed"); return }
        print ("✔️")
        
    case .deviceFirstStart, .deviceReboot:
        print ("\t#️⃣😇 device first start, reboot")
        try? lightDriver()
        if errStatus == ESP_OK {
            if (esp_zb_bdb_is_factory_new()) {
                print ("\t\t\(#function) Start network steering...", terminator:"") 
                topLevelComitioning (.networkSteering)
                print("✔️")
            } else {
                print ("\t\t\(#function) Device rebooted");
            }
        } else {
            print ("\t\t\(#function) \(esp_zb_zdo_signal_to_string(esp_zb_app_signal_type_t(sigType))) failed with status: \(esp_err_to_name(errStatus)), retrying")
            checkComitioning(.initialization)         
        }
        
    case .steering:
        print ("\t#️⃣😝 steering \(ESP_OK)")
        if (errStatus == ESP_OK) {
            print ("get channel and address...", terminator:"")
            typealias IEEEaddr = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)
            var extendedPanId: IEEEaddr = (0, 0, 0, 0, 0, 0, 0, 0)
            
            withUnsafeMutableBytes(of: &extendedPanId) { rawBuffer in
                let ptr = rawBuffer.baseAddress!.assumingMemoryBound(to: UInt8.self)
                esp_zb_get_extended_pan_id(ptr)
            }
            print ("✔️")
            // No need to delay — PAN ID should be immediately available now
            print("\t\tExtended PAN ID read: \(extendedPanId)")
            print ("\t\tDONE?")
            
            
            print ("\t\tJoined network successfully")
            let ieeeId = 
            "\(extendedPanId.7.x2)\(extendedPanId.6.x2)\(extendedPanId.5.x2)\(extendedPanId.4.x2)\(extendedPanId.3)\(extendedPanId.2.x2)\(extendedPanId.1.x2)\(extendedPanId.0.x2)"
            let pan = "\(esp_zb_get_pan_id())"
            let channel = "\(esp_zb_get_current_channel().x4)"
            let address = "\(esp_zb_get_short_address().x4)"
            print ("\t\t(Extended PAN ID: \(ieeeId), PAN ID:\(pan), Channel:\(channel), Short Address: \(address)")
        } else {
            print ("\t\tError status is not OK, try later")
            checkComitioning(.networkSteering) 
        }
         
    case .permitJoinStatus:
        print ("\t#️⃣😎 permit Join Status")
        if (errStatus == ESP_OK) {
            if let p = esp_zb_app_signal_get_params(p_sg_p) {
                print ("Network is open \(p)")
            } else {
                print ("Network is closed")
            }
        } else {
            
        }
        
    //MARK: Test, not in original demo
    case .productionConfigReady:
        print ("#️⃣ production Config Ready")
    default: print ("not this time \(sigType)")
    }
    
    
    
}

extension BinaryInteger {
    func hexStr(_ len: Int) -> String {
        let table:[Character] = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"]
        var value = self
        var result = "0x"
        for i in (0..<len).reversed() {
            let shift = i * 4
            let index = Int((value >> shift) & 0xF)
            result.append(table[table.index(table.startIndex, offsetBy: index)])
        }
        return result
    }
    var x2: String {
        self.hexStr(2)
    }
    var x4: String {
        self.hexStr(4)
    }
}
