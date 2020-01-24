# selenium-pom-example

[![Build Status](https://travis-ci.com/digital-delivery-academy/selenium-pom-exampe.svg?branch=master)](https://travis-ci.com/digital-delivery-academy/selenium-pom-exampe)

## Documentation

- A full reference guide is here: https://github.com/digital-delivery-academy/selenium-pom-framework/wiki
- Technical reference documentation (javadocs) are here: https://digital-delivery-academy.github.io/selenium-pom-framework/javadoc-0.0.5

## Getting started

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
