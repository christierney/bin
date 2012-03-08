# Source this file to add a "java-toggle" function that switches between
# java 6 and java 7.
#
# e.g.:
#    java-toggle 6
#
# Switching means setting JAVA_HOME to point to the correct location, and
# using update-alternatives to update java and javac.
#
# Calling java-toggle without an argument will print usage and the current
# status of JAVA_HOME, java, and javac.
#
# The two JAVA_HOME options are hard-coded.
# TODO: pick generic names (e.g. /usr/lib/jvm/java6) and require symlinks
#       to point to the real versioned install?

function java-toggle-usage {
    echo "usage: java-toggle <6|7>"
    echo
}

function java-toggle-display {
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
    [ -z $1 ] && java-toggle-usage && java-toggle-display && return 0

    v=$1

    java6="/usr/lib/jvm/java-6-sun"
    java7="/usr/lib/jvm/jdk1.7.0_02"

    if [ $v == 6 ]; then
        export JAVA_HOME=$java6
    elif [ $v == 7 ]; then
        export JAVA_HOME=$java7
    else
        echo "$v is not a supported java version!" >&2
        java-toggle-usage 
        return 1
    fi

    sudo update-alternatives --set java "$JAVA_HOME/bin/java"
    sudo update-alternatives --set javac "$JAVA_HOME/bin/javac"

    java-toggle-display
}
