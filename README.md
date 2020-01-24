# selenium-pom-example

[![Build Status](https://travis-ci.com/digital-delivery-academy/selenium-pom-exampe.svg?branch=master)](https://travis-ci.com/digital-delivery-academy/selenium-pom-exampe)

## Documentation

- A full reference guide is here: https://github.com/digital-delivery-academy/selenium-pom-framework/wiki
- Technical reference documentation (javadocs) are here: https://digital-delivery-academy.github.io/selenium-pom-framework/javadoc-0.0.5

## Getting started

There are some things that you need to install if you've never done this sort of thing before.  You're going to need
`Maven` and `Java` environment and IDE (like IntelliJ).  We've got a guide to getting started in the frameworks documentation
which you can find right here: https://github.com/digital-delivery-academy/selenium-pom-framework/wiki/1.-Getting-Started

You need to tell Maven how to access GitHub packages.  So you need to edit your `settings.xml`.

Typically you can do this by looking in `~/.m2/settings.xml`.  You will need a GitHub Personal Access Token, which
you can do here (once you're logged in): https://github.com/settings/tokens

An example configuration (`settings.xml`) would be:

```
<settings xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">

    <activeProfiles>
        <activeProfile>github</activeProfile>
    </activeProfiles>

    <profiles>
        <profile>
            <id>github</id>
            <repositories>
                <repository>
                    <id>central</id>
                    <url>https://repo1.maven.org/maven2</url>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                    <snapshots>
                        <enabled>false</enabled>
                    </snapshots>
                </repository>
                <repository>
                    <id>github</id>
                    <name>GitHub OWNER Apache Maven Packages</name>
                    <url>https://maven.pkg.github.com/digital-delivery-academy/selenium-pom-framework</url>
                </repository>
            </repositories>
        </profile>
    </profiles>
    <servers>
        <server>
            <id>github</id>
            <username>GITHUB_USERNAME</username>
            <password>GITHUB_PERSONAL_ACCESS_TOKEN_FOR_PACKAGES</password>
        </server>
    </servers>
</settings>
```
## Running the tests

There are two main ways that you'd typically run tests like this; from your machine while you're building things, and
from something like Travis or Jenkins etc (Continuous Integration tooling).

The tests themselves use a harness called JUnit underneath, and modern IDEs like IntelliJ know all about JUnit and how 
to run things in a nice way from your IDE.

The other way to run things is from `Maven`.  `Maven` is a build and dependency tool for Java applications.  To run all 
of the tests in your project following these instructions:

1. Open a Terminal window/session
2. Navigate to the project directory (hint: in IntelliJ, you can open a Terminal session that will start from the project directory)
3. Type the following: `mvn clean test`
4. Watch your browser dance

## The theory