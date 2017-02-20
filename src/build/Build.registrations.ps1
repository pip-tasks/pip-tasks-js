########################################################
##
## Build.registrations.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Registrations for build tasks 
##
#######################################################

$gtasks = "$PSScriptRoot/Gulp.tasks.ps1"

# Registrations for imperative tasks
Register-ImperativeInclude -CallFile $gtasks -Component

# Registrations for declarative tasks
Register-DeclarativeTask -Task Clean -Variable Build -Value gulp -CallFile $gtasks -CallTask GulpClean -Component
Register-DeclarativeTask -Task Build -Variable Build -Value gulp -CallFile $gtasks -CallTask GulpBuild -Component
Register-DeclarativeTask -Task Rebuild -Variable Build -Value gulp -CallFile $gtasks -CallTask GulpRebuild -Component
Register-DeclarativeTask -Task Watch -Variable Build -Value gulp -CallFile $gtasks -CallTask GulpWatch -Component


$tstasks = "$PSScriptRoot/Typescript.tasks.ps1"

# Registrations for imperative tasks
Register-ImperativeInclude -CallFile $tstasks -Component

# Registrations for declarative tasks
Register-DeclarativeTask -Task Clean -Variable Build -Value typescript -CallFile $tstasks -CallTask TSClean -Component
Register-DeclarativeTask -Task Build -Variable Build -Value typescript -CallFile $tstasks -CallTask TSBuild -Component
Register-DeclarativeTask -Task Rebuild -Variable Build -Value typescript -CallFile $tstasks -CallTask TSRebuild -Component
Register-DeclarativeTask -Task Watch -Variable Build -Value typescript -CallFile $tstasks -CallTask TSWatch -Component
