#!/bin/bash

# Configuration
SPARK_VERSION="4.1.1"
HADOOP_VERSION="3"
SPARK_TARBALL="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
DOWNLOAD_URL="https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_TARBALL}"
DEPS_DIR="deps"
COURSIER_URL="https://github.com/coursier/launchers/raw/master/coursier"

# Create deps directory if it doesn't exist
mkdir -p "$DEPS_DIR"

echo "Checking for Spark dependency: $SPARK_TARBALL"

if [ ! -f "$DEPS_DIR/$SPARK_TARBALL" ]; then
    echo "Downloading Spark $SPARK_VERSION..."
    curl -L -C - "$DOWNLOAD_URL" -o "$DEPS_DIR/$SPARK_TARBALL"
else
    echo "Spark tarball already exists in $DEPS_DIR. Skipping download."
fi

echo "Checking for Coursier dependency..."
if [ ! -f "$DEPS_DIR/coursier" ]; then
    echo "Downloading Coursier..."
    curl -L "$COURSIER_URL" -o "$DEPS_DIR/coursier"
    chmod +x "$DEPS_DIR/coursier"
else
    echo "Coursier already exists in $DEPS_DIR. Skipping download."
fi

echo "Done."
