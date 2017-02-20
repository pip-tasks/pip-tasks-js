########################################################
##
## Npm.tasks.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Npm build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Clears nuget dependencies
task NpmCleanDep {
    Clear-NpmDependencies -Path .
}

# Synopsis: Restore nuget dependencies
task NpmRestoreDep {
    Restore-NpmDependencies -Path .
}

# Synopsis: Update nuget dependency
task NpmUpdateDep {
    Update-NpmDependency -Path . -Dependency $Dependency -Version $Version
}
