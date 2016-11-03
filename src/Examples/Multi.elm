module Examples.Multi exposing (main)

import Interact exposing (Args)
import String


main : Program Args
main =
    let
        f flags =
            let
                fns =
                    flags
                        |> List.drop 1
                        |> List.map fnFromString
                        |> things
            in
                if List.length fns <= 0 then
                    always usage
                else
                    List.foldl (<<) identity fns
    in
        Interact.interactWithArgs f


fnFromString : String -> Maybe (String -> String)
fnFromString s =
    case s of
        "reverse" ->
            Just String.reverse

        "toLower" ->
            Just String.toLower

        "toUpper" ->
            Just String.toUpper

        "trim" ->
            Just String.trim

        "trimLeft" ->
            Just String.trimLeft

        "trimRight" ->
            Just String.trimRight

        _ ->
            Nothing


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


things : List (Maybe a) -> List a
things xs =
    case xs of
        [] ->
            []

        x :: xs ->
            case x of
                Just x ->
                    x :: things xs

                Nothing ->
                    things xs
