module Examples.ToUpper exposing (main)

import Interact exposing (Args)
import String


main : Program Args
main =
    Interact.interact String.toUpper
