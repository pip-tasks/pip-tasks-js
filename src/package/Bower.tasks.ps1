########################################################
##
## Bower.tasks.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Bower build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Gets version of Bower project
task BowerGetVersion {
    Get-BowerVersion -Path .
}

# Synopsis: Sets version of Bower project
task BowerSetVersion {
    assert ($Version -ne $null) "Version is not set"

    Set-BowerVersion -Path . -Version $Version
}

# Synopsis: Gets Bower dependencies
task BowerGetDep {
    Get-BowerDependencies -Path .
}

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
    assert ($Dependency -ne $null) "Dependency is not set"
    assert ($Version -ne $null -or $Dependency.Contains('@')) "Version is not set"

    Update-BowerDependency -Path . -Dependency $Dependency -Version $Version
}
