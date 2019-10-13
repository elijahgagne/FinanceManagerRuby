#!/bin/bash

set -x
set -e

yarn install
rake db:migrate
rake db:seed

puma -p 3000 -t $PUMA_MIN_THREADS:$PUMA_MAX_THREADS -w $PUMA_WORKERS --log-requests $PUMA_ARGS
