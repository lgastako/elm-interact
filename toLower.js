(function() {
    const fs   = require("fs");
    const Elm  = require("./elm.js");
    const log  = console.log;
    const show = JSON.stringify;
    const encoding = "utf-8";
    const elm = Elm.Examples.ToLower.worker(process.argv);
    elm.ports.stdout.subscribe(function(s) {
        process.stdout.write(s);
    });
    elm.ports.begin.subscribe(function() {
        let buffer = Buffer.alloc(0);
        process.stdin.on("data", function(chunk) {
            const totalLength = buffer.length + chunk.length;
            buffer = Buffer.concat([buffer, chunk], totalLength);
        });
        process.stdin.on("end", function() {
            elm.ports.stdin.send(buffer.toString(encoding));
        });
    });
})();
