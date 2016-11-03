module Examples.Fail exposing (main)

import Interact exposing (Args)


main : Program Args
main =
    Interact.interactWithArgsR fail


fail : Args -> String -> Result String String
fail args input =
    Err "FAIL."
