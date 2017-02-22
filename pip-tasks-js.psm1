########################################################
##
## pip-tasks-js.psm1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Startup module
##
#######################################################

$path = $PSScriptRoot
if ($path -eq "") { $path = "." }

. "$path\src\package\Npm.ps1"
. "$path\src\package\Bower.ps1"
. "$path\src\build\Gulp.ps1"
. "$path\src\build\Typescript.ps1"
. "$path\src\test\Mocha.ps1"
. "$path\src\run\Gulp.ps1"

. "$path\src\package\Package.registrations.ps1"
. "$path\src\build\Build.registrations.ps1"
. "$path\src\test\Test.registrations.ps1"
. "$path\src\run\Run.registrations.ps1"
