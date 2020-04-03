# selenium-pom-example
// TODO: Re-add badges

## Getting started

### Documentation

- A full reference guide is here (more work is needed here, and it's coming!): https://github.com/digital-delivery-academy/selenium-pom-framework/wiki
- Technical reference documentation (javadocs) are here: https://digital-delivery-academy.github.io/selenium-pom-framework/javadoc-1.0.10

### Running the tests

There are two main ways that you'd typically run tests like this; from your machine while you're building things, and
from something like Travis or Jenkins etc (Continuous Integration tooling).

The tests themselves use a harness called JUnit underneath, and modern IDEs like IntelliJ know all about JUnit and how 
to run things in a nice way from your IDE.

The other way to run things is from Maven (`mvn`).  Maven is a build and dependency tool for Java applications.  To run all 
of the tests in your project following these instructions:

1. Open a Terminal window/session
2. Navigate to the project directory (hint: in IntelliJ, you can open a Terminal session that will start from the project directory)
3. Type the following: `mvn clean test`
4. Watch your browser dance

### Running with Selenium Grid

Take a look in the `scripts/` directory and you'll see some `bash` scripts and a `docker-compose` YAML configuration file.

To start a Selenium Grid that is run in `docker` with attached nodes, all you need to do is run the `./start-docker-selenium-grid.sh`.  And to stop the containers,
just run the `./stop-docker-selenium-grid.sh`.

Remember that you need to switch up the options in your `config.json` file to switch the `runType` from `LOCAL` to `GRID`. 

### Running your tests from Docker

We supply a `Dockerfile` that will create an image for your to build containers from specifically for running your tests inside Docker.  This can be done locally and from a pipeline of course.
If you're intending to use Docker builds in your pipeline, probably best to run from a docker container locally as well to keep everything consistent.

The container will start with Firefox and Chrome installed.

First up, let's create the Docker image from the `Dockerfile` that's in the root of the repo.

`docker build --tag mvn .`

Once that's complete, we can run our tests with it:

`docker run -it --net grid --rm -v "$PWD"/target:/usr/src/app/target mvn test`

Note: Every time your code changes you need to run (it's super quick):

`docker build --tag mvn .`

## The theory

### Test vs Checking

Remember that automation isn't a replacement for testing.  It's a great way to express our existing knowledge about an application
that we're testing and then check it super quickly.  But, if an application is changed in the way it works (new features, 
bug fixes, configuration changes, deployment changes) then our automation isn't quite complete, because, the system is different
and we can longer rely on our knowledge ON ITS OWN.  We have to do something else as well.

This is where the difference between Testing and Checking comes in.

Test is defined by James Bach as:

_"Testing is the process of evaluating a product by learning about it through exploration and experimentation, which 
includes to some degree: questioning, study, modelling, observation, inference, etc."_

Checking is defined by James Bach as:

_"Checking is the process of making evaluations by applying algorithmic decision rules to specific observations of a product."_

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
