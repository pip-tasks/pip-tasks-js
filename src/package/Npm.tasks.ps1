########################################################
##
## Npm.tasks.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Npm build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Gets version of Npm project
task NpmGetVersion {
    Get-NpmVersion -Path .
}

# Synopsis: Sets version of Npm project
task NpmSetVersion {
    assert ($Version -ne $null) "Version is not set"

    Set-NpmVersion -Path . -Version $Version
}

# Synopsis: Gets Npm dependencies
task NpmGetDep {
    Get-NpmDependencies -Path .
}

# Synopsis: Clears Npm dependencies
task NpmCleanDep {
    Clear-NpmDependencies -Path .
}

# Synopsis: Restore Npm dependencies
task NpmRestoreDep {
    Restore-NpmDependencies -Path .
}

# Synopsis: Update Npm dependency
task NpmUpdateDep {
    assert ($Dependency -ne $null) "Dependency is not set"
    assert ($Version -ne $null -or $Dependency.Contains('@')) "Version is not set"

    Update-NpmDependency -Path . -Dependency $Dependency -Version $Version
}

# Synopsis: Publishes Npm package
task NpmPublish {
    Publish-Npm -Path .
}
