import Foundation
import ArgumentParser
// import Potrace
import CoreGraphicsImage
import CoreGraphics

public enum Errors: Error {
    case missingInput
    case unsupportedOS
    case invalidPixels
}

@available(macOS 10.15, *)
struct PotraceCLI: ParsableCommand {
    
    @Argument(help:"The path to an image file to extract text from.")
    var inputFile: String
    
    func run() throws {
        
        guard let im_url = URL(string: inputFile) else {
            throw(Errors.missingInput)
        }
        
        let im_rsp = CoreGraphicsImage.LoadFromURL(url: im_url)
             
        var cg_image: CGImage
        
        switch im_rsp {
        case .failure(let error):
            throw(error)
        case .success(let im):
            cg_image = im
        }
                
        let im_pixels = pixelValues(fromCGImage: cg_image)
        
        guard let im_data = UnsafeMutableRawPointer(mutating: im_pixels) else {
            throw(Errors.invalidPixels)
        }
        
        let potrace = Potrace(
            data: im_data,
            width: cg_image.width,
            height: cg_image.height
        )
        
        potrace.process()
        
        let bezierPath = potrace.getBezierPath()
        let svgString = potrace.getSVG()
        print(svgString)
    }
}

if #available(macOS 10.15, *) {
    PotraceCLI.main()
} else {
    throw(Errors.unsupportedOS)
}
