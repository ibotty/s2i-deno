# ubi8-s2i-deno
This project is just for exploring what a source-to-image (s2i) might look like
for Deno applications.

The idea here is that the s2i will provide the Deno runtime, and take a users
Typescript application and bundle, which is a feature in Deno which takes the
application and I think what it does is resovles dependencies and compiles
the Typescript into JavaScript which can then be executed by the Deno runtime.
Doing this in the assemble stage will mean that the startup time is improved.

Build this image:
```console
$ podman build -t nodeshift/ubi8-s2i-deno .
```

Run the image:
```console
$ podman run -it localhost/ubi8-s2i-deno /bin/bash
```

Build an s2i example-app, specifying which Typescript file is the main entry
point using the `MAIN` build argument:
```console
$ cd example-app
$ podman build . --build-arg MAIN=welcome.ts --build-arg PERMISSIONS="--allow-read=/etc" -t app
```
The `PERMISSION` build argument is an example of using Deno's permissions to
allow the application to read from the file system. Without this flag the an
error would be produced at runtime:
```console
error: Uncaught PermissionDenied: read access to "/etc/passwd", run again with the --allow-read flag
    at processResponse (core.js:226:13)
    at Object.jsonOpSync (core.js:250:12)
    at Object.lstatSync (deno:cli/rt/30_fs.js:216:22)
    at Object.existsSync (file:///opt/app-root/src/main.js:11267:18)
    at execute (file:///opt/app-root/src/main.js:11300:65)
    at gExp (file:///opt/app-root/src/main.js:91:7)
    at __instantiate (file:///opt/app-root/src/main.js:98:27)
    at file:///opt/app-root/src/main.js:11305:1
```

Running the example app:
```console
$ podman run -t localhost/app 
Welcome to Deno(14:24) 🦕
Does /etc/passwd exist: true
```

### TODO
* The image size is quite large and we might be able to use a smaller
base image.
* Also currently there are no permissions passed on when building but this should
not be to difficult to add in the same why that the MAIN entry ts file is specified.
