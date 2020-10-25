# ubi8-s2i-deno
This project is just for exploring what a source-to-image (s2i) might look like
for Deno applications.

The idea here is that the s2i will provide the Deno runtime, and take a users
Typescript application and bundle, which is a feature in Deno which takes the
application and I think what it does is resovles dependencies and compiles
the Typescript into JavaScript which can then be executed by the Deno runtime.
Doing this in the assemble stage will mean that the startup time is improved.

TODO: 
* The image size is quite large and we might be able to use a smaller 
base image.
* Also currently there are no permissions passed on when building but this should
not be to difficult to add in the same why that the MAIN entry ts file is specified.

Build this image:
```console
$ podman build -t ubi8-s2i-deno .
```

Run the image:
```console
$ podman run -it localhost/ubi8-s2i-deno /bin/bash
```

Build an s2i example-app, specifying which Typescript file is the main entry
point using the `MAIN` build argument:
```console
$ cd example-app
$ podman build . --build-arg MAIN=welcome.ts -t app
```
Running the example app:
```console
$ podman run -t localhost/app 
Welcome to Deno(12:48) 🦕
```
