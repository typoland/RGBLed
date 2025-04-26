
//MARK: MANUFACTURER INFO 
typealias Manufacturer = zcl_basic_manufacturer_info_t

struct ManufactureData {
    static var name = "ESPRESSIF"
    static var modelId = "esp32h2"
}

extension Manufacturer {
    init(name: String = ManufactureData.name, 
         identifier: String = ManufactureData.modelId) {
        self.init()
        
        let n: [UInt8] = [UInt8(name.utf8.count)] + Array(name.utf8) + [0]
        let i: [UInt8] = [UInt8(identifier.utf8.count)] + Array(identifier.utf8) + [0]
        
        let manufacturerBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: n.count)
        manufacturerBuffer.initialize(from: n, count: n.count)
        
        let modelBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: i.count)
        modelBuffer.initialize(from: i, count: i.count)
        
        manufacturer_name = UnsafeMutablePointer<CChar>(OpaquePointer(manufacturerBuffer))
        model_identifier = UnsafeMutablePointer<CChar>(OpaquePointer(modelBuffer))
        //print("\(#function) Before register: <\(manufacturer_name.pointee)> <\(model_identifier.pointee)")
    }
    
    func add(to endPoint: UnsafeMutablePointer<esp_zb_ep_list_t>,
             endpointId: UInt8) throws (ZigbeeError) {
        guard let clusterList = esp_zb_ep_list_get_ep(endPoint, endpointId) else {
            throw .manufacturerInfoFailed("ZCL_UTILITY: Failed to find endpoint id: \(endpointId) in list: \(endPoint)")
        }
        guard let basicCluster = esp_zb_cluster_list_get_cluster(
            clusterList,
            ZCL.Cluster.Id.basic.rawValue,   //ESP_ZB_ZCL_CLUSTER_ID_BASIC,
            ZCL.Cluster.Role.server.rawValue //ESP_ZB_ZCL_CLUSTER_SERVER_ROLE
        ) else {
            throw .manufacturerInfoFailed("ZCL_UTILITY: Failed to find basic cluster in endpoint: \(endpointId)")
        }
        esp_zb_basic_cluster_add_attr(basicCluster, 
                                      ZCL.BasicAttr.manufacturerName.rawValue, 
                                      manufacturer_name)
        esp_zb_basic_cluster_add_attr(basicCluster, 
                                      ZCL.BasicAttr.modelIdentifier.rawValue, 
                                      model_identifier)
    }
}
    
