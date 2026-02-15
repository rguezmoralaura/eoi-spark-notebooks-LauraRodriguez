# Configuration
$SPARK_VERSION = "4.1.1"
$HADOOP_VERSION = "3"
$SPARK_TARBALL = "spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz"
$DOWNLOAD_URL = "https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/$SPARK_TARBALL"
$DEPS_DIR = "deps"
$COURSIER_URL = "https://github.com/coursier/launchers/raw/master/coursier"

# Create deps directory if it doesn't exist
if (-not (Test-Path -Path $DEPS_DIR)) {
    New-Item -ItemType Directory -Path $DEPS_DIR | Out-Null
}

Write-Host "Checking for Spark dependency: $SPARK_TARBALL"

$SparkPath = Join-Path -Path $DEPS_DIR -ChildPath $SPARK_TARBALL
if (-not (Test-Path -Path $SparkPath)) {
    Write-Host "Downloading Spark $SPARK_VERSION..."
    Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile $SparkPath
} else {
    Write-Host "Spark tarball already exists in $DEPS_DIR. Skipping download."
}

Write-Host "Checking for Coursier dependency..."
$CoursierPath = Join-Path -Path $DEPS_DIR -ChildPath "coursier"
if (-not (Test-Path -Path $CoursierPath)) {
    Write-Host "Downloading Coursier..."
    Invoke-WebRequest -Uri $COURSIER_URL -OutFile $CoursierPath
} else {
    Write-Host "Coursier already exists in $DEPS_DIR. Skipping download."
}

Write-Host "Done."
