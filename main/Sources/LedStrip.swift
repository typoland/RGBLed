

struct LedStrip {
    enum Error: Swift.Error {
        case cannotOpenDevice(String)
        case cannotCreateHandle
    }
    
    private let handle: led_strip_handle_t
    
    init(gpioNr: Int32, maxLeds: UInt32)//, config: Config = .default )
    throws ( LedStrip.Error) {
        var handle = led_strip_handle_t(bitPattern: 0)
        var stripConfig = led_strip_config_t(
            strip_gpio_num: gpioNr,
            max_leds: maxLeds,
            led_pixel_format: LED_PIXEL_FORMAT_GRB,
            led_model: LED_MODEL_WS2812,
            flags: .init(invert_out: 0)
        )
        var spiConfig = led_strip_spi_config_t(
            clk_src: SPI_CLK_SRC_DEFAULT,
            spi_bus: SPI2_HOST,
            flags: .init(with_dma: 1)
        )
        switch runEsp({led_strip_new_spi_device(&stripConfig,
                                                &spiConfig,
                                                &handle)}) {
            case .failure(let msg): throw Error.cannotOpenDevice(msg)
            case .success:
            guard let handle = handle
                    else { throw .cannotCreateHandle }
            self.handle = handle
        }
    }
    func turnOn() {
        setPixel(index: 0, color: .white)
        refresh()
    }
    func turnOff() {
        setPixel(index: 0, color: .off)
        refresh()
    }
    func setPower(_ power: Bool) {
        power ? turnOn() : turnOff()
    }

    func setPixel(index: Int, color: RGBColor) {
        led_strip_set_pixel(
            handle, 
            UInt32(index), 
            UInt32(color.r), 
            UInt32(color.g), 
            UInt32(color.b))
    }
    
    func refresh() { led_strip_refresh(handle) }
    func clear() { led_strip_clear(handle) }
    
}


