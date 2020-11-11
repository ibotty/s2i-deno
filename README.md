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
$ podman build -t nodeshift/ubi8-s2i-deno
```
This will print the usage information.

### Using the s2i command with the sample project
There is an example Deno application in [example-app](./example-app) which can
be specified to be build by s2i to produce a runnable image using the following
commands:
```console
$ s2i build file:///$PWD nodeshift/ubi8-s2i-deno:latest --context-dir=example-app deno-sample-app -e MAIN="src/welcome.ts" -e PERMISSIONS="--allow-read=/etc"

$ docker run -t deno-sample-app
Welcome to Deno(14:24) 🦕
Does /etc/passwd exist: true
```

### Configuration options
There are options specified as environment variables using the `-e` option for
s2i build command.

#### MAIN
The TypeScript/JavaScript file which is the main entry point for the app.

#### PERMISSIONS
Are optional [PERMISSIONs](https://deno.land/manual/getting_started/permissions) 
that can be set using the PERMISSIONS environment variable.

#### TSCONFIG
Is an optional build option to specify a TypeScript configuration file.

### Running the example app:
```console
$ podman run -t localhost/app 
Welcome to Deno(14:24) 🦕
Does /etc/passwd exist: true
```
