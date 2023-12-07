# swift-potrace-cli

## Tools

### potrace

```
$> swift build

$> ./.build/debug/potrace -h
USAGE: potrace-cli <input-file> [--svg-type <svg-type>] [--fill-svg <fill-svg>] [--turn-policy <turn-policy>] [--turd-size <turd-size>] [--opt-curve <opt-curve>] [--alpha-max <alpha-max>] [--opt-tolerance <opt-tolerance>]

ARGUMENTS:
  <input-file>            The path to an image file to extract text from.

OPTIONS:
  --svg-type <svg-type>   If set to 'curve'
  --fill-svg <fill-svg>   Fill SVG paths. (default: true)
  --turn-policy <turn-policy>
                          Determine how to resolve ambiguities in path decomposition. Valid options are: black, white, left, right, minority, majority. (default: minority)
  --turd-size <turd-size> Suppress speckles of up to this size. (default: 2)
  --opt-curve <opt-curve> Turn on/off curve optimization. (default: true)
  --alpha-max <alpha-max> Corner threshold parameter. (default: 1.0)
  --opt-tolerance <opt-tolerance>
                          Curve optimization tolerance. (default: 0.2)
  -h, --help              Show help information.

```

## See also

* https://github.com/sfomuseum/swift-potrace
