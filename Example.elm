module Example exposing (main)

import Interact exposing (Flags, interact)
import String


main : Program Flags
main =
    interact String.toUpper
