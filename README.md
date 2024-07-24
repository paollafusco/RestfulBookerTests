# Functional Test Repository for Restful-Booker API Tests using Karate DSL

## Table of Contents
- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Running Tests](#running-tests)
- [Reporting](#reporting)

## Introduction
This repository contains functional tests for the [Restful-Booker](https://restful-booker.herokuapp.com/apidoc/index.html) API using the [Karate DSL](https://github.com/intuit/karate) framework.

## Prerequisites
- Java JDK 11
- Maven 3.9.8 or higher
- Git

## Project Structure

    ├── src/
    │ ├── test/
    │ │ ├── java/
    │ │ │ └── runner/
    │ │ │   └── KarateRunner.java
    │ │ ├── resources/
    │ │ │ └── features/ 
    │ │ │   └── example.feature 
    │ │ │   └── helpers/
    │ │ │     └── exampleHelper.feature 
    │ │ │ └── karate-config.js
    │ └── main/
    │   └──java/
    ├── pom.xml
    └── README.md

## Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/paollafusco/RestfulBookerTests.git
    ```
2. Install the dependencies:
    ```bash
    mvn clean install
    ```

## Running Tests
To run the tests, execute the following Maven command:
```bash
mvn clean test
```

You can also run a specific feature file by using the command below and replacing the tag with one of the ones at the beginning of each feature:
```bash
mvn test -Dkarate.options="--tags @getTests"
```

## Configuration
Configuration settings for the tests can be specified in the karate-config.js file located in the src/test/resources directory. This file allows you to set global variables and configure environment-specific settings.

## Reporting
After running the tests, a test report will be generated in the ’target/karate-reports’ directory. Open the ’karate-summary.html’ file in your browser to view the test results.

