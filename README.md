# elm-interact

Like [Haskell's `interact` function](https://hackage.haskell.org/package/base-4.9.0.0/docs/Prelude.html#v:interact) but for Elm.

To quote from the Haskell docs:

> The interact function takes a function of type String->String as its
> argument. The entire input from the standard input device is passed to this
> function as its argument, and the resulting string is output on the standard
> output device.

The elm part is easy, e.g. to create a program that converts it's input to upper case:

```elm
module Upper exposing (main)

import Interact exposing (Flags)
import String


main : Program Flags
main =
    interact String.toUpper
```

If you want to use command line arguments you can use `interactArgs`.

    TODO: Example of interactArgs

You should use the `index.js` included in the projection or something like it
to bootstrap your program from javascript.

## License

Copyright (c) 2016 John Evans.
