import Foundation
import ArgumentParser
import Potrace
import CoreGraphicsImage
import CoreGraphics

public enum Errors: Error {
    case missingInput
    case invalidImage
    case unsupportedOS
}

@available(macOS 10.15, *)
struct PotraceCLI: ParsableCommand {
    
    @Argument(help:"The path to an image file to extract text from.")
    var inputFile: String
    
    @Option(help:"If set to 'curve'")
    var svgType: String = ""
    
    @Option(help:"Fill SVG paths.")
    var fillSVG: Bool = true
    
    @Option(help:"Determine how to resolve ambiguities in path decomposition. Valid options are: black, white, left, right, minority, majority.")
    var turnPolicy: String = "minority"

    @Option(help:"Suppress speckles of up to this size.")
    var turdSize: Int = 2
        
    @Option(help:"Turn on/off curve optimization.")
    var optCurve: Bool = true
    
    @Option(help:"Corner threshold parameter.")
    var alphaMax: Double = 1.0
    
    @Option(help:"Curve optimization tolerance.")
    var optTolerance: Double = 0.2
    
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
        
        var settings = Settings()
        settings.turnpolicy = turnPolicy
        settings.turdsize = turdSize
        settings.optcurve = optCurve
        settings.alphamax = alphaMax
        settings.opttolerance = optTolerance
        
        let potrace = try Potrace(image: cg_image)
        potrace.process(settings: settings)
        
        var opt_type = ""
        
        if !fillSVG {
            opt_type = "curve"
        }
        
        let svgString = potrace.getSVG(opt_type:opt_type)
        print(svgString)
    }
}

if #available(macOS 10.15, *) {
    PotraceCLI.main()
} else {
    throw(Errors.unsupportedOS)
}
