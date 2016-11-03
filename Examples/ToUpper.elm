module Examples.ToUpper exposing (main)

import Interact exposing (Flags)
import String


main : Program Flags
main =
    Interact.interact String.toUpper
