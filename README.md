# <img src="https://github.com/pip-tasks/pip-tasks-ps/raw/master/artifacts/logo.png" alt="Pip.Devs Logo" style="max-width:30%"> <br/> Javascript and Node.js build tasks for Pip.Tasks

This Powershell module contains tasks for [Pip.Tasks](https://github.com/pip-tasks/pip-tasks-ps) to build Javascript and Node.js components

### NPM package management tasks

NPM package definition is defined by **package.json** file in the root folder of the component.

NPM tasks:
* **GetVersion** - gets version of NPM project
* **SetVersion** - sets version of NPM project
  - **Version** - version parameter
* **GetDep** - gets NPM dependencies
* **CleanDep** - cleans packages with NPM dependencies
* **RestoreDep** - downloads NPM dependencies 
* **UpdateDep** - updates dependency to specified version
  - **Dependency** - dependency name parameter
  - **Version** - dependency version parameter
* **Publish** - publishes NPM package to global repository

NPM configuration variables:
* **Package** - Turns on NPM tasks (must be 'npm')

### Bower package management tasks

Bower package definition is defined by **bower.json** file in the root folder of the component.

Bower tasks:
* **GetVersion** - gets version of Bower project
* **SetVersion** - sets version of Bower project
  - **Version** - version parameter
* **GetDep** - gets Bower dependencies
* **CleanDep** - cleans packages with Bower dependencies
* **RestoreDep** - downloads Bower dependencies
* **UpdateDep** - updates dependency to specified version
  - **Dependency** - dependency name parameter
  - **Version** - dependency version parameter

Bower configuration variables:
* **Package** - Turns on Bower tasks (must be 'bower')

### Guil build and run tasks

Gulp tasks are defined in **gulpfile.js** file in the root folder of the component.

Gulp tasks:
* **Clean** - cleans projects with Gulp (gulp clean)
* **Build** - builds projects  with Gulp (gulp clean)
* **Rebuild** - rebuilds projects with Gulp (gulp rebuild)
* **Watch** - watches for changes in projects and builds them with Gulp (gulp watch)
* **Start** - runs projects with Gulp (gulp launch)

Gulp configuration variables:
* **Build** - Turns on Gulp build tasks (must be 'gulp')
* **Run** - Turns on Gulp runt tasks (must be 'gulp')

### Typescript build tasks

Typescript compiler configuration it defined by **tsconfig.json** file in the root folder of the component.

Typescript tasks:
* **Clean** - cleans projects with Typscript (output path defined in tsconfig.json)
* **Build** - builds projects  with Typescript (tsc)
* **Rebuild** - rebuilds projects with Typescript (combination of Clean and Build)
* **Watch** - watches for changes in projects and builds them with Typescript (tsc --watch)

Typescript configuration variables:
* **Build** - Turns on Typescript tasks (must be 'typescript')

### Mocha test tasks

Mocha tasks:
* **Test** - runs Mocha tests

Mocha configuration variables:
* **Test** - Turns on Mocha tasks (must be 'mocha')
* **TestInclude** - Folder or list of folders there Mocha tests are located
* **TestStyle** - Mocha test style: tdd or bdd
* **TestTimeout** - Timeout in milliseconds for each test to complete (default: 10000)

## Installation

* Checkout **pip-tasks-ps** and **pip-tasks-js-ps** modules
* Add folder with the modules to **PSModulePath**
* Import **pip-tasks-js-ps** module. **pip-tasks-ps** will be imported automatically

## Usage

Let's say you have a Node.js component, implemented in Typescript and tested with Mocha.

The file structure may look the following:
```bash
/workspace
  ...
  /component1
    /node_modules
    /obj
    /src
    /test
    component.conf.ps1
    package.json
    tsconfig.json
```

**component.conf.ps1** file:
```powershell
$VersionControl = 'git'
$Package = 'npm'
$Build = 'typescript'
$Document = 'none'

$Test = 'mocha'
$TestInclude = './obj/test'
$TestTimeout = 10000
$TestStyle = 'tdd'

$Deploy = 'none'
$Run = 'none'
```

A typical scenario to work with this component may include the following steps:

* Pull changes from Git repository
```powershell
> Invoke-Task -Task Pull -Component component1
```

* Install npm packages
```powershell
> Invoke-Task -Task RestoreDep -Component component1
```

* Compile component with Typescript
```powershell
> Invoke-Task -Task Rebuild -Component component1
```

* Test component with Mocha
```powershell
> Invoke-Task -Task Test -Component component1
```

* Change version of external dependency
```powershell
> Invoke-Task -Task UpdateDep -Dependency component2 -Version 1.2.0 -Component component1
```

* Set new version for the component and push changes to Git repository
```powershell
> Invoke-Task -Task SetVersion -Version 1.0.1 -Component component1
> Invoke-Task -Task Push -Message "My changes" -Component component1
```

* Set tag to Git repository and publish public release
```powershell
> Invoke-Task -Task SetTag v1.0.1 -Component component1
> Invoke-Task -Task Publish -Component component1
```

Instead of typing full Powershell command 
```powershell
> Invoke-Task -Task getchanges -Component component1
```
you can use shortcuts like:
```powershell
> piptask getchanges
```

For more information about **Pip.Tasks** build infrastructure read documentation 
from the master project [here...](https://github.com/pip-tasks/pip-tasks-ps)

## Acknowledgements

This module created and maintained by **Sergey Seroukhov**.
