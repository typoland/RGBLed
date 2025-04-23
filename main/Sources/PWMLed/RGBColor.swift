protocol ColorProtocol {
    associatedtype Owner
}

struct RGB<T>: ColorProtocol {
    typealias Owner = T
    var r: T
    var g: T
    var b: T
}

//struct Monochrome<T>: ColorProtocol {
//    typealias Owner = T
//    var value: T
//}


typealias ColorValue = UInt8
typealias RGBColor  = RGB<ColorValue>
//typealias MonoColor = Monochrome<ColorValue>


struct PWMChannelAssign<CH> {
    var channel: CH
    var gpio: GPIO
}

typealias LedChannelAssign = PWMChannelAssign<LedChannel>


extension RGBColor {

    static var white      = RGBColor(r: 255, g: 255, b: 255)
    static var off        = RGBColor(r: 0,   g: 0,   b: 0)
    static var red        = RGBColor(r: 255, g: 0,   b: 0)
    static var green      = RGBColor(r: 0,   g: 255, b: 0)
    static var blue       = RGBColor(r: 0,   g: 0,   b: 255)
    static var lightWhite = RGBColor(r: 16,  g: 16,  b: 16)
    static var lightRandom: RGBColor {
        RGBColor(
            r: .random(in: 16...32), 
            g: .random(in: 4...16), 
            b: .random(in: 0...8))
    }
    static var random: RGBColor {
        RGBColor(
            r: .random(in: 127...255), 
            g: .random(in: 8...64), 
            b: .random(in: 0...32))
    }
}
extension ColorValue {
    static var full = 255
    static var half = 127
    static var off  = 0
}

/*
//MARK: Active Channel
enum ActiveChannel: String {
    case r
    case g
    case b
    var next: ActiveChannel {
        switch self {
        case .r: return .g
        case .g: return .b
        case .b: return .r
        }
    }
}
extension RGBColor  {
    func channel(_ channel: ActiveChannel) -> RGBColor {
        switch channel {
        case .r: return RGBColor(r: r, g: 0, b: 0) 
        case .g: return RGBColor(r: 0, g: g, b: 0) 
        case .b: return RGBColor(r: 0, g: 0, b: b)
        }
    }
}

*/
