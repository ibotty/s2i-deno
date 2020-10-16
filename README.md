# ubi8-s2i-deno

### Install s2i
```console
$ sudo dnf install -y s2i
```

Build this image:
```console
$ podman build -t ubi8-s2i-deno .
```

Run the image:
```console
$ podman run -it localhost/ubi8-s2i-deno /bin/bash
```

Build an s2i example-app
```console
$ cd example-app
$ podman build . --build-arg MAIN=welcome.ts -t app
```
Running the example app:
```console
$ podman run -t localhost/app 
Check file:///opt/app-root/src/welcome.ts
Welcome to Deno 🦕
```
