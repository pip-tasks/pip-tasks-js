########################################################
##
## Test.registrations.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Registrations for test tasks 
##
#######################################################

$mtasks = "$PSScriptRoot/Mocha.tasks.ps1"

# Registrations for imperative tasks
Register-ImperativeInclude -CallFile $mtasks -Component

# Registrations for declarative tasks
Register-DeclarativeTask -Task Test -Variable Test -Value mocha -CallFile $mtasks -CallTask MochaTest -Component
