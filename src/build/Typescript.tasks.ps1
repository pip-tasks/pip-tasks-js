########################################################
##
## Typescript.tasks.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Common build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Clears Typescript project
task TSClean {
    Clear-TSBuild -Path .
}

# Synopsis: Builds Typescript project
task TSBuild {
    Invoke-TSBuild -Path .
}

# Synopsis: Rebuilds Typescript project
task TSRebuild {
    Invoke-TSRebuild -Path .
}

# Synopsis: Watches changes in Typescript project and builds
task TSWatch {
    Watch-TSBuild -Path .
}
