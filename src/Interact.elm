port module Interact exposing (Args, interact, interactWithArgs)

{-| The Interact library provides the Haskell-alike interact (and
interactWithArgs) functions.

@docs Args
@docs interact
@docs interactWithArgs

-}

import Worker


type Msg
    = Stdin String


{-| Args is just an alias for a List String representing command line args.
-}
type alias Args =
    List String


type alias Model =
    { flags : Args
    , contents : String
    }


port begin : () -> Cmd msg


port stdout : String -> Cmd msg


port stdin : (String -> msg) -> Sub msg


{-| The interact function takes a function of type String -> String as its
argument. The entire input from the standard input device is passed to this
function as its argument, and the resulting string is output on the standard
output device.

    module Upper exposing (main)

    import Interact exposing (Args)
    import String


    main : Program Args
    main =
        interact String.toUpper
-}
interact : (String -> String) -> Program Args
interact f =
    Worker.programWithFlags doNotLogModel
        { init = init
        , update = update f
        , subscriptions = subs
        }


{-| The interactWithArgs function is like interact but the function you pass to
it must take an additional `flags` argument as a first argument.

    module Upper exposing (main)

    import Interact exposing (Args)
    import String


    main : Program Args
    main =
        interactWithArgs \flags s -> (String.join "\n" flags) ++ "\n" ++ s
-}
interactWithArgs : (Args -> String -> String) -> Program Args
interactWithArgs f =
    Worker.programWithFlags doNotLogModel
        { init = init
        , update = updateWithArgs f
        , subscriptions = subs
        }


init : Args -> ( Model, Cmd msg )
init flags =
    { emptyModel | flags = flags } ! [ begin () ]


update : (String -> String) -> Msg -> Model -> ( Model, Cmd msg )
update f msg model =
    case msg of
        Stdin input ->
            model ! [ stdout (f input) ]


updateWithArgs : (Args -> String -> String) -> Msg -> Model -> ( Model, Cmd msg )
updateWithArgs f msg model =
    update (f (List.drop 1 model.flags)) msg model


doNotLogModel : Model -> Cmd Msg
doNotLogModel =
    always Cmd.none


subs : Model -> Sub Msg
subs model =
    Sub.batch [ stdin Stdin ]


emptyModel : Model
emptyModel =
    { flags = emptyArgs
    , contents = ""
    }


emptyArgs : List String
emptyArgs =
    []
