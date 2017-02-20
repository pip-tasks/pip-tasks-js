########################################################
##
## Naven.tasks.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Java test tasks
##
#######################################################

# Set correct path when invoked from other scripts
$BuildRoot = $BuildPath

# Synopsis: Tests Mocha project
task MochaTest {
    Invoke-MochaTest -Path . -Include $TestInclude -Timeout $TestTimeout -Style $TestStyle
}
