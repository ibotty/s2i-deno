# ubi8-s2i-deno
This project is just for exploring what a
[source-to-image](https://github.com/openshift/source-to-image) (s2i) might look
like for [Deno](https://deno.land/) applications.

The goal here is that a user can have a Deno project, for example on github,
and use the `s2i` build command to point to that project and `s2i` will generate
an container with that application which can then be run. The container will
include Deno and run the application when the image is run.

As part of the assemble stage this Deno `s2i` will use Deno's `bundle` command to
resovle and download any depedencies, as well as compile any TypeScript so that
this does not have to happen at runtime.

### Building
```console
$ docker build -t dbevenius/ubi8-s2i-deno .
```

### Running
Run this image (will print the usage):
```console
$ docker build -t dbevenius/ubi8-s2i-deno
```
This will print the usage information.

### Example usage
There is an example Deno application in [example-app](./example-app) which can
be specified to be built by `s2i` to produce a runnable image using the following
commands.

Build using `s2i`:
```console
$ s2i build https://github.com/danbev/deno-example dbevenius/ubi8-s2i-deno:0.1 deno-sample-app -e MAIN="src/welcome.ts" -e PERMISSIONS="--allow-read=/etc"
```
And then run the produced image:
```console
$ docker run -t deno-sample-app
Welcome to Deno(14:24) 🦕
Does /etc/passwd exist: true
```

### Configuration options
There are options specified as environment variables using the `-e` option for
`s2i` build command.

#### MAIN
The TypeScript/JavaScript file which is the main entry point for the app.

#### PERMISSIONS
Are optional [PERMISSIONs](https://deno.land/manual/getting_started/permissions) 
that can be set using the PERMISSIONS environment variable.

#### TSCONFIG
Is an optional build option to specify a TypeScript configuration file.
