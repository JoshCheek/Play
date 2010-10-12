#!/usr/bin/env sh

cd $(cd $(dirname $0); pwd -P)

echo "Showing what the script sees for \$arg1, \$arg2, \$arg3, \$arg4"
echo

echo "BASIC BOOLEAN ARGS:"
echo "./show-options.rb -arg1 -arg3"
./show-options.rb -arg1 -arg3
echo

echo "SETTIN VARIABLES:"
echo "./show-options.rb -arg2=123 -arg3='abc def' -arg4=./hello-world.rb"
./show-options.rb -arg2=123 -arg3='abc def' -arg4=./hello-world.rb
echo

echo "MIX OF BOTH:"
echo "./show-options.rb -arg2 -arg3='abc def' -arg4=123"
./show-options.rb -arg2 -arg3='abc def' -arg4=123