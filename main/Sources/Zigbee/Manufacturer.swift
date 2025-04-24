
//MARK: MANUFACTURER INFO 
typealias Manufacturer = zcl_basic_manufacturer_info_t
extension Manufacturer {
    init(name: String = ManufactureData.name, 
         identifier: String = ManufactureData.modelId) {
        self.init()
        
        let n: [UInt8] = Array(name.utf8)
        let i: [UInt8] = Array(identifier.utf8)
        
        let manufacturerBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: n.count)
        manufacturerBuffer.initialize(from: n, count: n.count)
        
        let modelBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: i.count)
        modelBuffer.initialize(from: i, count: i.count)
        
        manufacturer_name = UnsafeMutablePointer<CChar>(OpaquePointer(manufacturerBuffer))
        model_identifier = UnsafeMutablePointer<CChar>(OpaquePointer(modelBuffer))
    }
    
    func add(to epList: UnsafeMutablePointer<esp_zb_ep_list_t>,
             endpointId: UInt8) throws (ZigbeeError) {
        guard let clusterList = esp_zb_ep_list_get_ep(epList, endpointId) else {
            throw .manufacturerInfoFailed("ZCL_UTILITY: Failed to find endpoint id: \(endpointId) in list: \(epList)")
        }
        guard let basicCluster = esp_zb_cluster_list_get_cluster(
            clusterList,
            ZCL.Cluster.Id.basic.rawValue, //ESP_ZB_ZCL_CLUSTER_ID_BASIC,
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
    /*
        guard let name = self.pointee.manufacturer_name else {
            throw .manufacturerInfoFailed("ZCL_UTILITY: Invalid manufacturer name")
        }
        
        switch runEsp({
            esp_zb_basic_cluster_add_attr(basicCluster, 
                                          ZCL.BasicAttr.manufacturerName.rawValue, 
                                          name)}) 
        {
        case .success: break
        case .failure(let err): throw .manufacturerInfoFailed(err)
        }
        
        guard let model = self.pointee.model_identifier else {
            throw .manufacturerInfoFailed("ZCL_UTILITY: Invalid model identifier")
        }
        switch runEsp({
            esp_zb_basic_cluster_add_attr(basicCluster, 
                                          ZCL.BasicAttr.modelIdentifier.rawValue, 
                                          model)})
        {
        case .success: break
        case .failure(let err): throw .manufacturerInfoFailed(err)
        }
     */
    }
}
    
    
    /*
     func addBasicManufacturerInfo(
     to epList: UnsafeMutablePointer<esp_zb_ep_list_t>,
     endpointId: UInt8,
     info: UnsafePointer<zcl_basic_manufacturer_info_t>
     ) throws (ZigbeeError) {
     
     guard let clusterList = esp_zb_ep_list_get_ep(epList, endpointId) else {
     throw .manufacturerInfoFailed("ZCL_UTILITY: Failed to find endpoint id: \(endpointId) in list: \(epList)")
     }
     
     guard let basicCluster = esp_zb_cluster_list_get_cluster(
     clusterList,
     ZCL.Cluster.Id.basic.rawValue, //ESP_ZB_ZCL_CLUSTER_ID_BASIC,
     ZCL.Cluster.Role.server.rawValue //ESP_ZB_ZCL_CLUSTER_SERVER_ROLE
     ) else {
     throw .manufacturerInfoFailed("ZCL_UTILITY: Failed to find basic cluster in endpoint: \(endpointId)")
     }
     
     guard let name = info.pointee.manufacturer_name else {
     throw .manufacturerInfoFailed("ZCL_UTILITY: Invalid manufacturer name")
     }
     
     switch runEsp({
     esp_zb_basic_cluster_add_attr(basicCluster, 
     ZCL.BasicAttr.manufacturerName.rawValue, 
     name)}) 
     {
     case .success: break
     case .failure(let err): throw .manufacturerInfoFailed(err)
     }
     
     guard let model = info.pointee.model_identifier else {
     throw .manufacturerInfoFailed("ZCL_UTILITY: Invalid model identifier")
     }
     switch runEsp({
     esp_zb_basic_cluster_add_attr(basicCluster, 
     ZCL.BasicAttr.modelIdentifier.rawValue, 
     model)})
     {
     case .success: break
     case .failure(let err): throw .manufacturerInfoFailed(err)
     }
     }
     */
