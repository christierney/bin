#!/bin/bash

function usage {
    echo "usage: java-toggle <6|7>"
    echo
}

function display {
    echo "JAVA_HOME=$JAVA_HOME"
    echo
    echo "java version:"
    java -version
    echo
    echo "javac version:"
    javac -version
}

function java-toggle {
    # quit fast if called with no arguments
    [ -z $1 ] && usage && display && return 0

    v=$1

    java6="/usr/lib/jvm/java-6-sun"
    java7="/usr/lib/jvm/jdk1.7.0_02"

    if [ $v == 6 ]; then
        export JAVA_HOME=$java6
    elif [ $v == 7 ]; then
        export JAVA_HOME=$java7
    else
        echo "$v is not a supported java version!" >&2
        usage 
        return 1
    fi

    sudo update-alternatives --set java "$JAVA_HOME/bin/java"
    sudo update-alternatives --set javac "$JAVA_HOME/bin/javac"

    display
}
