(function() {
    const fs = require("fs");
    const encoding = "utf-8";
    const Elm = require("./elm.js");
    const elm = Elm.Examples.ToLower.worker(process.argv);
    elm.ports.stdout.subscribe(function(s) {
        process.stdout.write(s);
        process.exit(0);
    });
    elm.ports.stderr.subscribe(function(s) {
        process.stderr.write(s);
        process.exit(1);
    });
    let buffer = Buffer.alloc(0);
    process.stdin.on("data", function(chunk) {
        const totalLength = buffer.length + chunk.length;
        buffer = Buffer.concat([buffer, chunk], totalLength);
    });
    process.stdin.on("end", function() {
        elm.ports.stdin.send(buffer.toString(encoding));
    });
})();
