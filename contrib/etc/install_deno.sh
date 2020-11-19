#!/bin/bash

set -ex
curl -fsSL https://deno.land/x/install/install.sh | sh -s v${DENO_VERSION}
