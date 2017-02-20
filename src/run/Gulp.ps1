########################################################
##
## Gulp.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Gulp commands
##
#######################################################

function Start-Gulp
{
<#
.SYNOPSIS

Launches Gulp project 

.DESCRIPTION

Start-Gulp launches gulp project

.PARAMETER Path

Path to Gulp project (default: .)

.EXAMPLE

PS> Start-Gulp -Path .

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.'
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            Invoke-External { 
                & gulp launch
            } "Project launch with Gulp failed"
        }
    }
    end {}
}
