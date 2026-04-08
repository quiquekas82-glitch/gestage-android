#!/usr/bin/env sh
APP_HOME=$(dirname "$(readlink -f "$0" 2>/dev/null || echo "$0")" 2>/dev/null || pwd)
CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar

DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'

if [ -n "$JAVA_HOME" ] ; then
    JAVACMD="$JAVA_HOME/bin/java"
else
    JAVACMD="java"
fi

exec "$JAVACMD" $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS \
    "-Dorg.gradle.appname=GestAge" \
    -classpath "$CLASSPATH" \
    org.gradle.wrapper.GradleWrapperMain \
    "$@"
