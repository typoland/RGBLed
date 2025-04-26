func checkComitioningLater(_ mode: ComissionigMode, after ms: UInt32 = 1000) {
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

    let espIsOK: ESPError = signal.pointee.esp_err_status == ESP_OK 
    ? .success
    : .failure(String(cString: esp_err_to_name(errStatus)))
    
    guard let signalType = AppSignalType(rawValue: p_sg_p?.pointee ?? 0)
    else { print ("....undefined signal...."); return } //esp_zb_app_signal_type_t

    
    // Prepare optional parameter pointers
//    var devAnnceParams: UnsafeMutablePointer<esp_zb_zdo_signal_device_annce_params_t>? = nil
//    var leaveIndParams: UnsafeMutablePointer<esp_zb_zdo_signal_leave_indication_params_t>? = nil

    print("🔁 Zigbee signal received: \(signalType.rawValue.x2):(\(signalType.description)), status=\(error)")
    
    switch (signalType) {
    case .skipStartup: 
        print ("\t#️⃣😍 Initialize Zigbee stack...", terminator: "")
        guard .success == topLevelComitioning(.initialization)
        else {print ("❌ Initialize Zigbee stack failed"); return }
        print ("✔️")
        
    case .deviceFirstStart, .deviceReboot:
        print ("\t#️⃣😇 device first start, reboot")
        try? lightDriver()
        
        switch espIsOK {
        case .success:
            if (esp_zb_bdb_is_factory_new()) {
                print ("\t\t\(#function) Start network steering...", terminator:"") 
                topLevelComitioning (.networkSteering)
                print("✔️")
            } else {
                print ("\t\t\(#function) Device rebooted");
            }
        case .failure(let error):
            print ("\t\t\(#function) \(signalType.description))) failed with status: \(error), retrying")
            checkComitioningLater(.initialization)         
        }
        
    case .steering:
        print ("\t#️⃣😝 steering \(ESP_OK)")
        switch espIsOK {
        case .success:
            print ("\t\tget channel and address...", terminator:"")
            var extendedPanId = IEEE(by: esp_zb_get_extended_pan_id)
            print ("✔️")
            print ("\t\tJoined network successfully")
            print ("\t\t(Extended PAN ID: \(extendedPanId.description), PAN ID:\(esp_zb_get_pan_id().x4), Channel:\(esp_zb_get_current_channel().x4), Short Address: \(esp_zb_get_short_address().x4)")
        case .failure(let error):
            print ("\t\t🛑 Error status is not OK (status: \(error)), try later")
            checkComitioningLater(.networkSteering) 
        }
         
    case .permitJoinStatus:
        print ("\t#️⃣😎 permit Join Status")
        switch espIsOK {
        case .success:
            if let p = esp_zb_app_signal_get_params(p_sg_p) {
                print ("\t\tNetwork (\(esp_zb_get_pan_id().x4)) is open \(p)")
            } else {
                print ("\t\tNetwork (\(esp_zb_get_pan_id().x4)) is closed, devices joining not allowed.")
            }
        default: break
        }

    default: print ("🙈 unimplemented Signal: \(signalType.rawValue.x2):\(signalType.description) ")
    }
}

struct IEEE {
    typealias IEEEAddr = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)
    var address: IEEEAddr = (0, 0, 0, 0, 0, 0, 0, 0)
    init(by setter:  (_ address: UnsafeMutablePointer<UInt8>?) -> ()) {
        withUnsafeMutableBytes(of: &address) { rawBuffer in
            let ptr = rawBuffer.baseAddress!.assumingMemoryBound(to: UInt8.self)
            setter(ptr)
        } 
    }
    var description: String {
        "\(address.7.x2):\(address.6.x2):\(address.5.x2):\(address.4.x2):\(address.3):\(address.2.x2):\(address.1.x2):\(address.0.x2)"
    }
}

extension BinaryInteger {
    func hexStr(_ len: Int) -> String {
        let table:[Character] = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"]
       // var value = self
        var result = "0x"
        for i in (0..<len).reversed() {
            let shift = i * 4
            let index = Int((self >> shift) & 0xF)
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
