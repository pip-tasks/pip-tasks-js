########################################################
##
## Build.registrations.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Registrations for ruin tasks 
##
#######################################################

$gtasks = "$PSScriptRoot/Gulp.tasks.ps1"

# Registrations for imperative tasks
Register-ImperativeInclude -CallFile $gtasks -Component

# Registrations for declarative tasks
Register-DeclarativeTask -Task Start -Variable Run -Value gulp -CallFile $gtasks -CallTask GulpStart -Component
