########################################################
##
## Package.registrations.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Registrations for package management tasks 
##
#######################################################

$npmtasks = "$PSScriptRoot/Npm.tasks.ps1"

# Registrations for imperative tasks
Register-ImperativeInclude -CallFile $npmtasks -Component

# Registrations for declarative tasks
Register-DeclarativeTask -Task CleanDep -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmCleanDep -Component
Register-DeclarativeTask -Task RestoreDep -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmRestoreDep -Component
Register-DeclarativeTask -Task UpdateDep -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmUpdateDep -Component


$bwtasks = "$PSScriptRoot/Bower.tasks.ps1"

# Registrations for imperative tasks
Register-ImperativeInclude -CallFile $bwtasks -Component

# Registrations for declarative tasks
Register-DeclarativeTask -Task CleanDep -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerCleanDep -Component
Register-DeclarativeTask -Task RestoreDep -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerRestoreDep -Component
Register-DeclarativeTask -Task UpdateDep -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerUpdateDep -Component
