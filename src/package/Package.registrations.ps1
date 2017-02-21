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
Register-DeclarativeTask -Task GetVersion -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmGetVersion -Component
Register-DeclarativeTask -Task SetVersion -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmSetVersion -Component
Register-DeclarativeTask -Task GetDep -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmGetDep -Component
Register-DeclarativeTask -Task CleanDep -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmCleanDep -Component
Register-DeclarativeTask -Task InstallDep -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmInstallDep -Component
Register-DeclarativeTask -Task UpdateDep -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmUpdateDep -Component
Register-DeclarativeTask -Task Publish -Variable Package -Value npm -CallFile $npmtasks -CallTask NpmPublish -Component


$bwtasks = "$PSScriptRoot/Bower.tasks.ps1"

# Registrations for imperative tasks
Register-ImperativeInclude -CallFile $bwtasks -Component

# Registrations for declarative tasks
Register-DeclarativeTask -Task GetVersion -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerGetVersion -Component
Register-DeclarativeTask -Task SetVersion -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerSetVersion -Component
Register-DeclarativeTask -Task GetDep -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerGetDep -Component
Register-DeclarativeTask -Task CleanDep -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerCleanDep -Component
Register-DeclarativeTask -Task InstallDep -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerInstallDep -Component
Register-DeclarativeTask -Task UpdateDep -Variable Package -Value bower -CallFile $bwtasks -CallTask BowerUpdateDep -Component
