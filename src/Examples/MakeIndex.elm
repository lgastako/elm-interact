module Examples.MakeIndex exposing (main)

import Interact exposing (Args)
import String


main : Program Args
main =
    Interact.interactWithArgsR makeIndex


makeIndex : Args -> String -> Result String String
makeIndex =
    Debug.crash "makeIndex not implemented"
