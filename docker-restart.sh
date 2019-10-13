#!/bin/sh
#
#
# Send a 'restart' command to the puma web server process
#
# This script is intended to be run inside the docker container
# using 'docker exec'
#
#
# Need to locate the pid of the main puma process.
# Just grepping for 'puma' will find worker processes (and the grep command itself):
#
# root@d7499004f8e2:/usr/src/app# ps -ef |grep puma
# root        11     1  0 10:07 ?        00:00:01 puma 3.10.0 (tcp://0.0.0.0:3000) [app]
# root       605    11  0 13:30 ?        00:00:00 puma: cluster worker 0: 11 [app]
# root       609    11  0 13:30 ?        00:00:00 puma: cluster worker 1: 11 [app]
# root       661   639  0 13:36 pts/0    00:00:00 grep puma
#
#
# To filter down to just the process we want, in the grep string:
#   the space after puma ('puma ') is to exclude this worker processes
#   the []s around the 'p' keep the grep command from matching
#
# root@d7499004f8e2:/usr/src/app# ps -ef |grep '[p]uma '
# root        11     1  0 10:07 ?        00:00:01 puma 3.10.0 (tcp://0.0.0.0:3000) [app]
#



# build the pumactl command
cmd=`ps -ef |grep '[p]uma ' | awk '{printf("pumactl -p %s restart\n", $2);}'`

# Turn on command echoing & run it
set -x
$cmd
