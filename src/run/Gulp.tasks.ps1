########################################################
##
## Gulp.tasks.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Common build tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Starts Gulp project
task GulpStart {
    Start-Gulp -Path .
}
