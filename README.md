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

import Interact exposing (Args)
import String


main : Program Args
main =
    interact String.toUpper
```

If you want to use command line arguments you can use `interactArgs`.

    TODO: Example of interactArgs

You should use the `index.js` included in the projection or something like it
to bootstrap your program from javascript.

You can see a more complicated example in `Example.elm` which is a program that
allows you to compose a pipeline of the Elm `String` functions.

It can be used like so:

    % node index.js reverse toUpper
    foo bar
    baz bif
    ^D
    FIB ZAB
    RAB OOF

TODO: document `interactR` and `interactWithArgsR`.

## Known Issues / Limitations

- Assumes utf-8 encoding
- Reads entire file at once

## License

`elm-interact` is made availabl under the BSD3 open source license.

Copyright (c) 2016 John Evans.
