########################################################
##
## Bower.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Bower commands
##
#######################################################

function Clear-BowerDependencies
{
<#
.SYNOPSIS

Clears Bower dependencies

.DESCRIPTION

Clear-BowerDependencies removed dependencies folder with Bower dependencies

.PARAMETER Path

Path to Bower project (default: .)

.EXAMPLE

PS> Clear-BowerDependencies -Path .

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
            if (Test-Path -Path "./bower_components")
            {
                Remove-Item -Recurse -Force "./bower_components"
            }
        }
    }
    end {}
}

function Restore-BowerDependencies
{
<#
.SYNOPSIS

Installs Bower dependencies

.DESCRIPTION

Restore-BowerDependencies installs Bower dependencies

.PARAMETER Path

Path to Bower project (default: .)

.EXAMPLE

PS> Restore-BowerDependencies -Path .

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
                & bower install
            } "Failed to install bower dependencies"
        }
    }
    end {}
}


function Update-BowerDependency
{
<#
.SYNOPSIS

Updates version of Bower dependency

.DESCRIPTION

Update-BowerDependency updates versions of Bower dependency(s) specified by name or source

.PARAMETER Path

Path to Bower project (default: .)

.PARAMETER Dependency

Dependency name

.PARAMETER Version

Dependency version

.EXAMPLE

PS> Update-BowerDependency -Path . -Dependency pip-webui-all -Version 1.5.*

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.',
        [Parameter(Mandatory=$false, Position=1, ValueFromPipelineByPropertyName=$true)]
        [string] $Dependency,
        [Parameter(Mandatory=$false, Position=2, ValueFromPipelineByPropertyName=$true)]
        [string] $Version
    )
    begin {}
    process 
    {
        if ($Dependency -eq $null -or $Dependency -eq '') { return }
        if ($Dependency.Contains('@'))
        {
            $pos = $Dependency.IndexOf('@')
            $Dependency = $Dependency.Substring(0, $pos)
            $Version = $Dependency.Substring($pos + 1)
        }
        
        Invoke-At $Path {
            # Update all dependencies from specified source
            if ($Dependency -eq $null -or $Dependency -eq '')
            {                        
                Invoke-External { 
                    & bower update --save
                } "Failed to update bower dependencies"
            }
            # Update specific dependency if it exists
            else 
            {
                Invoke-External { 
                    & bower update $Dependency --save
                } "Failed to update bower dependency"
            }
        }
    }
    end {}
}
