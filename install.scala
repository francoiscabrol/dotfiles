#!/bin/sh
exec scala "$0" "$@"
!#

import sys.process._

val value = "Hello world"
val homeDir = sys.env("HOME")

println(value)

("ls "+homeDir).!
print(sys.env("HOME"))

