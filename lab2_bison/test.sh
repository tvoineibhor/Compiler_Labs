#!/bin/bash

BIN=$1


TEST_INPUT_DIR_CORRECT="tests/input/correct"
TEST_INPUT_DIR_INCORRECT="tests/input/incorrect"


function assert {
    if [ `echo $?` == $1 ]
    then
        echo -e "  Test $2 \033[0;32mDONE!\033[0m"
    else
        echo -e "  Test $2 \033[0;31mErr\033[0m"
    fi
}

function test {

    echo "$1 TESTS"

    local i=1

    for files in $2/*; do
        
        $BIN $files
        assert $3 $i

        i=$((i + 1))
    done
}

test "CORRECT" $TEST_INPUT_DIR_CORRECT 0
test "INCORRECT" $TEST_INPUT_DIR_INCORRECT 1

