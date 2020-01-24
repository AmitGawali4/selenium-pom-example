# selenium-pom-example

[![Build Status](https://travis-ci.com/digital-delivery-academy/selenium-pom-exampe.svg?branch=master)](https://travis-ci.com/digital-delivery-academy/selenium-pom-exampe)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a4ef36d50ff44f9abee05b81921e7ff8)](https://www.codacy.com/gh/digital-delivery-academy/selenium-pom-example?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=digital-delivery-academy/selenium-pom-example&amp;utm_campaign=Badge_Grade)

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

### Test vs Checking

Remember that automation isn't a replacement for testing.  It's a great way to express our existing knowledge about an application
that we're testing and then check it super quickly.  But, if an application is changed in the way it works (new features, 
bug fixes, configuration changes, deployment changes) then our automation isn't quite complete, because, the system is different
and we can longer rely on our knowledge ON ITS OWN.  We have to do something else as well.

This is where the difference between Testing and Checking comes in.

Test is defined by James Bach as:

"Testing is the process of evaluating a product by learning about it through exploration and experimentation, which 
includes to some degree: questioning, study, modelling, observation, inference, etc."

Checking is defined by James Bach as:

"Checking is the process of making evaluations by applying algorithmic decision rules to specific observations of a product."

So, automation is therefore incapable of testing by it's very nature.  Automation is powerful, we need it, but
be careful with it and ensure you understand it's limitations.

### Automation via the UI

Checking in the UI is meant to represent the smallest number or percentage of checks in our automation approach.
Typically, it's suggested that around 5-10% of all automated checking is completed in the UI.

This is because:

- it's brittle (pages change all the time)
- it's slow (we're simulating a user, users are slow)
- it's a pain in the ass to keep up-to-date

Many people invest an inverse amount of time to their UI checks, relative to the strategic goals of 5-10%.

Good things to avoid in UI checking:

- don't write a check for each acceptance criteria, focus instead on end-to-end journeys or complete scenarios
- in your scenarios, encompass negative checks that you want to do, don't write explicit checks for them
- `Thread.sleep` (read the framework documentation to learn how to avoid this)

### The Page Object Model

The Page Object Model is a design pattern.  Design patterns in programming help us solve common problems in common ways
following similar approaches that have worked for similar problems that others have faced.

The Page Object Model is super straight forward; one class typically represents one page in the application under test.  This is
known as the Page Object.

Page Objects encapsulate actions and elements.  Elements are private.  And actions are public.  This allows callers to see 
all of the actions that they can take on a page, without having to be exposed to the complexity "under the hood".

There's an important (and often overlooked) aspect of the Page Object Model design pattern, and it really makes tests
super tidy and really easy for less experienced people to use, and it's this; Page Object actions should return to the caller
a Page Object that the caller will end up on as a result of the action.  If the caller will stay where they are, then
the action should `return this`.  If it will move the application under test to a new page, then it should return a Page Object
that represents the new page, so the action should `return new PageObjectThatWeEndUpOn()`.  