module Interact exposing (interact, interactArgs)

import Worker


type Msg
    = NoOp


interact : (String -> String) -> Program Never
interact f =
    Worker.program doNotLogModel
        { init = init
        , update = update f
        , subscriptions = subs
        }


interactArgs : (flags -> String -> String) -> Program flags
interactArgs f =
    Worker.programWithFlags doNotLogModel
        { init = initWithArgs
        , update = updateWithArgs f
        , subscriptions = subs
        }


init : ( flags, Cmd msg )
init =
    Debug.crash "Interact.init not implemented"


initWithArgs : flags -> ( flags, Cmd msg )
initWithArgs =
    Debug.crash "Interact.initWithArgs not implemented"


update : (String -> String) -> (Msg -> flags -> ( flags, Cmd msg ))
update f =
    Debug.crash "Interact.update not implemented"


updateWithArgs : (flags -> String -> String) -> (Msg -> flags -> ( flags, Cmd msg ))
updateWithArgs f =
    Debug.crash "Interact.updateWithArgs not implemented"


doNotLogModel : a -> Cmd b
doNotLogModel =
    always Cmd.none


subs : flags -> Sub a
subs =
    always Sub.none
