#!/bin/bash

BIN=$1

TEST_OUTPUT_SAMPLE="tests/output/test1.txt"
TEST_INPUT_SAMPLE="tests/input/test1.txt"
TMP_OUTPUT="tmp/test1.txt"

mkdir -p "tmp/"

$BIN $TEST_INPUT_SAMPLE >& $TMP_OUTPUT
diff -q $TEST_OUTPUT_SAMPLE $TMP_OUTPUT

if [ `echo $?` == 0 ]
then
    echo -e "\033[0;32mDONE!\033[0m"
else
    echo -e "\033[0;31mErr\033[0m"
fi
