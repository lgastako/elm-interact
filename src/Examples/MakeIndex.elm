module Examples.MakeIndex exposing (main)

import Interact exposing (Args)
import Regex exposing (HowMany(All), regex)


main : Program Args
main =
    Interact.interactWithArgsR makeIndex


makeIndex : Args -> String -> Result String String
makeIndex args input =
    Result.map (\v -> Regex.replace All (regex "__MAIN_NAMESPACE__") (always v) input)
        <| case List.drop 1 args of
            x :: y :: zs ->
                Err <| "ERROR: too many arguments " ++ toString (args) ++ "\n\n" ++ usage

            x :: xs ->
                Ok x

            [] ->
                Ok "Main"


usage : String
usage =
    """make-index

Usage:
    make-index [module]
    make-index (-h | --help)
    make-index --version

Options:
  -h --help     Show this screen.
  --version     Show version.

"""
