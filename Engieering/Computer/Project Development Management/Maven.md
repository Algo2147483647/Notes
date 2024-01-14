# $Maven$
[toc]

# Introduction
Maven is a powerful build automation and dependency management tool primarily used in Java-based projects. It provides a consistent and standardized way to manage software projects and their dependencies, making the build process more efficient and reliable. Maven addresses two aspects of building software:
- it describes how software is built.
- it describes its dependencies.


# Standard File Architecture
```shell
- /
  - src
    - main
      - java        # the directory of source code
      - resource    # directory of resource files
        - application.properties
      - webapp      # the directory of web source code, including .html, web.xml
  - test
    - main
      - java        # the directory of test code
      - resource    # directory of test resource files
  - target
  - pom.xml 
```

`mvn archetype:generate` will automatically generate file architecture.

# Dependency Management
* Dependence storage
* Dependence introduction
* Dependence Conflict Resolution
  
## Repository of Maven
The repositories are responsible to store Java libraries, plugins, and other build artifacts. 

- Local repository  
  This is on your conputer's hard drive. By default, Maven creates a `.m2` directory in the user's home folder and all downloaded or user-installed libraries will be stored in this folder.
- Remote repositoty
  - Central repository  
    This is Maven's default repository where it downloads all the necessary project dependencies. It is hosted by the community with free access for everyone.  [```https://mvnrepository.com/```](https://mvnrepository.com/). It is noteworthy that the Central repository only includes open source repositories.
  - Private repository  
    This are developer-defined repository meant to aid and collaborate with other developers in the team or an organization.

## Coordinates of Maven
Coordinates of Maven refers to the unique identifier of a project, which includes the following elements,

* ```groupId```  
  identify the organization of the project, and is usually named by the inverted domain name of the organization.
* ```artifactId```  
  common name of the project.
* ```version```  
  a specific version of the project. 

```xml
<dependency>
    <groupId>...</groupId>
    <artifactId>...</artifactId>
    <version>...</version>
</dependency>
```

# POM
POM (Project Object Model), (pop.xml)

```xml
<repositories>
    <repository>
        <id>my-internal-site</id>
        <url>http://myinternalserver/repo</url>
    </repository>
</repositories>
```

# Lifecircle
A Maven lifecircle is a sequence of defined phases that determine the order in which the goals are executed.  

* /
  * `clean`
  * `compile` 
  * `test`
  * `packet`
  * `install`

* clean lifecycle
  * `pre-clean`
  * `clean`
  * `post-clean`

* default(build) lifecycle
  * `validate`: Validates that the project structure is correct and all necessary information is available.
  * `initialize`: Initializes build state, such as setting properties or creating directories.
  * `generate-sources`: Generates any source code needed for inclusion in compilation.
  * `process-sources`: Processes the source code (for example, filtering files).
  * `generate-resources`: Generates resources that should be included in the package.
  * `process-resources`: Copies and processes the resources into the destination directory, ready for packaging.
  * `compile`: Compiles the source code of the project.
  * `process-classes`: Processes the compiled files from the compilation process (for example, to optimize bytecode).
  * `generate-test-sources`: Generates any test source code.
  * `process-test-sources`: Processes the test source code (for example, to filter any files).
  * `generate-test-resources`: Creates the resources for testing.
  * `process-test-resources`: Copies and processes the resources into the test destination directory.
  * `test-compile`: Compiles the test source code into the test destination directory.
  * `process-test-classes`: Post-processes the results of the test compilation.
  * `test`: Runs tests using a suitable unit testing framework.
  * `prepare-package`: Performs any operations necessary to prepare a package before the actual packaging.
  * `package`: Packs the compiled code in its distributable format, such as JAR, WAR, etc.
  * `pre-integration-test`: Performs actions required before integration tests are executed.
  * `integration-test`: Processes and deploys the package if necessary into an environment where integration tests can be run.
  * `post-integration-test`: Performs actions required after integration tests have been executed.
  * `verify`: Runs checks to verify that everything is in line with the quality criteria.
  * `install`: Installs the package into the local repository, for use as a dependency in other projects locally.
  * `deploy`: Copies the final package to the remote repository for sharing with other developers and projects.
* site lifecycle
  * `pre-site` 
  * `site`
  * `post-site`
  * `site-deploy`

