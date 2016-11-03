port module Interact exposing (Flags, interact, interactWithFlags)

{-| The Interact library provides the Haskell-alike interact (and
interactWithFlags) functions.

@docs Flags
@docs interact
@docs interactWithFlags

-}

import Worker


type Msg
    = Stdin String


{-| Flags is just an alias for a List String representing command line args.
-}
type alias Flags =
    List String


type alias Model =
    { flags : Flags
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

    import Interact exposing (Flags)
    import String


    main : Program Flags
    main =
        interact String.toUpper
-}
interact : (String -> String) -> Program Flags
interact f =
    Worker.programWithFlags doNotLogModel
        { init = init
        , update = update f
        , subscriptions = subs
        }


{-| The interactWithFlags function is like interact but the function you pass to
it must take an additional `flags` argument as a first argument.

    module Upper exposing (main)

    import Interact exposing (Flags)
    import String


    main : Program Flags
    main =
        interactWithFlags \flags s -> (String.join "\n" flags) ++ "\n" ++ s
-}
interactWithFlags : (Flags -> String -> String) -> Program Flags
interactWithFlags f =
    Worker.programWithFlags doNotLogModel
        { init = init
        , update = updateWithArgs f
        , subscriptions = subs
        }


init : Flags -> ( Model, Cmd msg )
init flags =
    { emptyModel | flags = flags } ! [ begin () ]


update : (String -> String) -> Msg -> Model -> ( Model, Cmd msg )
update f msg model =
    case msg of
        Stdin input ->
            model ! [ stdout (f input) ]


updateWithArgs : (Flags -> String -> String) -> Msg -> Model -> ( Model, Cmd msg )
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
    { flags = emptyFlags
    , contents = ""
    }


emptyFlags : List String
emptyFlags =
    []
