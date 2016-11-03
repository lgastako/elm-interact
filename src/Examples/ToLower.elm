module Examples.ToLower exposing (main)

import Interact exposing (Args)
import String


main : Program Args
main =
    Interact.interact String.toLower
