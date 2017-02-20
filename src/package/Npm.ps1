########################################################
##
## Npm.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Npm commands
##
#######################################################

function Clear-NpmDependencies
{
<#
.SYNOPSIS

Clears Npm dependencies

.DESCRIPTION

Clear-NpmDependencies removed dependencies folder with npm dependencies

.PARAMETER Path

Path to Npm project (default: .)

.EXAMPLE

PS> Clear-NpmDependencies -Path .

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
            if (Test-Path -Path "./node_modules")
            {
                Remove-Item -Recurse -Force "./node_modules"
            }
        }
    }
    end {}
}

function Restore-NpmDependencies
{
<#
.SYNOPSIS

Installs Npm dependencies

.DESCRIPTION

Restore-NpmDependencies installs Npm dependencies

.PARAMETER Path

Path to Npm project (default: .)

.EXAMPLE

PS> Restore-NpmDependencies -Path .

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
                & npm install
            } "Failed to install npm dependencies"
        }
    }
    end {}
}


function Update-NpmDependency
{
<#
.SYNOPSIS

Updates version of Npm package or dependencies

.DESCRIPTION

Update-NpmDependency updates versions of Npm package(s) specified by name or source

.PARAMETER Path

Path to Npm project (default: .)

.PARAMETER Dependency

Dependency name

.EXAMPLE

PS> Update-NpmDependency -Path . -Dependency pip-webui-all@1.5.*

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.',
        [Parameter(Mandatory=$false, Position=1, ValueFromPipelineByPropertyName=$true)]
        [string[]] $Dependency = @()
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            # Update all dependencies from specified source
            if ($Dependency -eq $null -or $Dependency.Count -eq 0)
            {                        
                Invoke-External { 
                    & npm update --save
                } "Failed to update npm dependencies"
            }
            # Update specific dependency if it exists
            else 
            {
                Invoke-External { 
                    & npm update $Dependency --save
                } "Failed to update npm package"
            }
        }
    }
    end {}
}
