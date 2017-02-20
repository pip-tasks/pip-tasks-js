# <img src="https://github.com/pip-tasks/pip-tasks-ps/raw/master/artifacts/logo.png" alt="Pip.Devs Logo" style="max-width:30%"> <br/> Javascript and Node.js build tasks for Pip.Tasks

This Powershell module brings tasks for Pip.Tasks to build Javascript and Node.js components

**NPM** tasks turned on by property **$Package = 'npm'**
* **CleanDep** - cleans packages with NPM dependencies
* **RestoreDep** - downloads NPM packages references by projects 
* **UpdateDep** - updates selected package or all packages from specified source to the latest compatible version

**Bower** tasks turned on by property **$Package = 'bower'**
* **CleanDep** - cleans packages with Bower dependencies
* **RestoreDep** - downloads Bower packages references by projects 
* **UpdateDep** - updates selected package or all packages from specified source to the latest compatible version

**Gulp** tasks turned on by property **$Build = 'gulp'** and **$Run = 'gulp'**
* **Clean** - cleans projects with Gulp (gulp clean)
* **Build** - builds projects  with Gulp (gulp clean)
* **Rebuild** - rebuilds projects with Gulp (gulp rebuild)
* **Watch** - watches for changes in projects and builds them with Gulp (gulp watch)
* **Start** - runs projects with Gulp (gulp launch)

**Typescript** tasks turned on by property **$Build = 'typescript'**
* **Clean** - cleans projects with Typscript (output path defined in tsconfig.json)
* **Build** - builds projects  with Typescript (tsc)
* **Rebuild** - rebuilds projects with Typescript (combination of Clean and Build)
* **Watch** - watches for changes in projects and builds them with Typescript (tsc --watch)

**Mocha** tasks turned on by property **$Build = 'mocha'**
* **Test** - runs Mocha tests

## Installation

* Checkout **pip-tasks-ps** and **pip-tasks-js-ps** modules
* Add folder with the modules to **PSModulePath**
* Import **pip-tasks-js-ps** module. **pip-tasks-ps** will be imported automatically

## Usage

TBD...

## Acknowledgements

This module created and maintained by **Sergey Seroukhov**.
