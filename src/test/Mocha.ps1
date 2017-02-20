########################################################
##
## Mocha.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Mocha commands
##
#######################################################

function Invoke-MochaTest
{
<#
.SYNOPSIS

Runs Mocha to test project

.DESCRIPTION

Invoke-MochaTest executes Mocha tests

.PARAMETER Path

Path to Maven project (default: .)

.EXAMPLE

PS> Invoke-MochaTest -Path .

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.',
        [Parameter(Mandatory=$false, Position=1, ValueFromPipelineByPropertyName=$true)]
        [string[]] $Include = @(),
        [Parameter(Mandatory=$false, Position=2, ValueFromPipelineByPropertyName=$true)]
        [int] $Timeout,
        [Parameter(Mandatory=$false, Position=3, ValueFromPipelineByPropertyName=$true)]
        [string] $Style
    )
    begin {}
    process 
    {
        if ($Timeout -eq $null) { $Timeout = 10000 }
        if ($Style -eq $null -or $Style -eq '') { $Style = 'bdd' }

        Invoke-At $Path {
            Invoke-External { 
                & mocha -t $Timeout -R spec -u $Style --recursive $Include
            } "Running Mocha test failed"
        }
    }
    end {}
}
