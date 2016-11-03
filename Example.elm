module Example exposing (main)

import Interact exposing (Flags)
import String


-- main : Program Flags
-- main =
--     interact String.toUpper


main : Program Flags
main =
    let
        f flags =
            let
                flags =
                    List.drop 1 flags
            in
                case flags of
                    [ "reverse" ] ->
                        String.reverse

                    [ "toLower" ] ->
                        String.toLower

                    [ "toUpper" ] ->
                        String.toUpper

                    [ "trim" ] ->
                        String.trim

                    [ "trimLeft" ] ->
                        String.trimLeft

                    [ "trimRight" ] ->
                        String.trimRight

                    _ ->
                        always usage
    in
        Interact.interactFlags f


usage : String
usage =
    """Elm Interactions.

Usage:
    interact reverse
    interact toLower
    interact toUpper
    interact trim
    interact trimLeft
    interact trimRight

Options:
  -h --help     Show this screen.
  --version     Show version.
"""
