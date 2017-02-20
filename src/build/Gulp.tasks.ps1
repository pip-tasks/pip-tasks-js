########################################################
##
## Gulp.tasks.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Common build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Clears Gulp project
task GulpClean {
    Clear-GulpBuild -Path .
}

# Synopsis: Builds Gulp project
task GulpBuild {
    Invoke-GulpBuild -Path .
}

# Synopsis: Rebuilds Gulp project
task GulpRebuild {
    Invoke-GulpRebuild -Path .
}

# Synopsis: Watches changes in Gulp project and builds
task GulpWatch {
    Watch-GulpBuild -Path .
}
