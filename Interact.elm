port module Interact exposing (Flags, interact, interactFlags)

import Worker


type Msg
    = Stdin String


type alias Flags =
    List String


type alias Model =
    { flags : Flags
    , contents : String
    }


port begin : () -> Cmd msg


port stdout : String -> Cmd msg


port stdin : (String -> msg) -> Sub msg


interact : (String -> String) -> Program Flags
interact f =
    Worker.programWithFlags doNotLogModel
        { init = init
        , update = update f
        , subscriptions = subs
        }


interactFlags : (Flags -> String -> String) -> Program Flags
interactFlags f =
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
