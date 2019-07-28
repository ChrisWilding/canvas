import Dependencies._

ThisBuild / scalaVersion     := "2.13.0"
ThisBuild / version          := "0.1.0-SNAPSHOT"
ThisBuild / organization     := "uk.co.chriswilding"
ThisBuild / organizationName := "chriswilding"

lazy val root = (project in file("."))
  .settings(
    name := "Canvas",
    libraryDependencies += scalaTest % Test
  )
