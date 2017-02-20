########################################################
##
## Bower.tasks.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Bower build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Clears nuget dependencies
task BowerCleanDep {
    Clear-BowerDependencies -Path .
}

# Synopsis: Restore nuget dependencies
task BowerRestoreDep {
    Restore-BowerDependencies -Path .
}

# Synopsis: Update nuget dependency
task BowerUpdateDep {
    Update-BowerDependency -Path . -Dependency $Dependency -Version $Version
}
