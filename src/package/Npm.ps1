########################################################
##
## Npm.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Npm commands
##
#######################################################

function Get-NpmVersion
{
<#
.SYNOPSIS

Gets version of Npm project

.DESCRIPTION

Get-NpmVersion gets version of Npm project

.PARAMETER Path

Path to Npm project (default: .)

.EXAMPLE

PS> Get-NpmVersion -Path .

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
            if (Test-Path -Path package.json)
            {
                $pkg = Get-Content -Path package.json | ConvertFrom-Json
                Write-Output $pkg.version
            }
        }
    }
    end {}
}


function Set-NpmVersion
{
<#
.SYNOPSIS

Sets version of Npm project

.DESCRIPTION

Set-NpmVersion sets version of Npm project

.PARAMETER Path

Path to Npm project (default: .)

.PARAMETER Version

New version of the Npm project

.EXAMPLE

PS> Get-NpmVersion -Path .

#>    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.',
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [string] $Version
    )
    begin {}
    process 
    {
        Invoke-At $Path {
            if (Test-Path -Path package.json)
            {
                $pkg = Get-Content -Path package.json | ConvertFrom-Json
                $pkg.version = $Version
                $pkg | ConvertTo-Json | Set-Content -Path package.json
            }
        }
    }
    end {}
}


function Get-NpmDependencies
{
<#
.SYNOPSIS

Gets all Npm dependencies

.DESCRIPTION

Get-NpmDependencies gets all Npm dependencies and their versions

.PARAMETER Path

Path to Npm project (default: .)

.EXAMPLE

PS> Get-NpmDependencies -Path .

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
            if (Test-Path -Path package.json)
            {
                $pkg = Get-Content -Path package.json | ConvertFrom-Json

                $deps = @{}

                $ds = ConvertTo-Hashtable -InputObject $pkg.dependencies
                foreach ($d in $ds.Keys)
                {
                    $dep = $d + '@' + $ds[$d]
                    $deps[$dep] = $dep
                }

                $ds = ConvertTo-Hashtable -InputObject $pkg.devDependencies
                foreach ($d in $ds.Keys)
                {
                    $dep = $d + '@' + $ds[$d]
                    $deps[$dep] = $dep
                }

                $deps.Keys | Sort-Object | Write-Output
            }
        }
    }
    end {}
}


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

function Install-NpmDependencies
{
<#
.SYNOPSIS

Installs Npm dependencies

.DESCRIPTION

Install-NpmDependencies installs Npm dependencies

.PARAMETER Path

Path to Npm project (default: .)

.EXAMPLE

PS> Install-NpmDependencies -Path .

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

Updates version of Npm dependency

.DESCRIPTION

Update-NpmDependency updates version of Npm dependency

.PARAMETER Path

Path to Npm project (default: .)

.PARAMETER Dependency

Dependency name

.PARAMETER Version

Dependency version

.EXAMPLE

PS> Update-NpmDependency -Path . -Dependency pip-webui-all -Version 1.5.*

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $Path = '.',
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
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
            $pos = $Dependency.LastIndexOf('@')
            $Dependency = $Dependency.Substring(0, $pos)
            $Version = $Dependency.Substring($pos + 1)
        }

        Invoke-At $Path {
            if (Test-Path -Path package.json)
            {
                $pkg = Get-Content -Path package.json | ConvertFrom-Json

                $ds = ConvertTo-Hashtable -InputObject $pkg.dependencies
                foreach ($d in $ds.Keys)
                {
                    if ($d.Contains($Dependency))
                    {
                        Write-Host "Updated $d to version $Version"
                        
                        $pkg.dependencies.$d = $Version
                    }
                }

                $ds = ConvertTo-Hashtable -InputObject $pkg.devDependencies
                foreach ($d in $ds.Keys)
                {
                    if ($d.Contains($Dependency))
                    {
                        Write-Host "Updated $d to version $Version"
                        
                        $pkg.devDependencies.$d = $Version
                    }
                }

                ConvertTo-Json -InputObject $pkg | Set-Content -Path package.json
            }
        }
    }
    end {}
}


function Publish-Npm
{
<#
.SYNOPSIS

Publishes Npm package

.DESCRIPTION

Publish-Npm publishes Npm package

.PARAMETER Path

Path to Npm project (default: .)

.EXAMPLE

PS> Publish-Npm -Path .

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
                & npm login
            } "Failed to login to npm"

            Invoke-External { 
                & npm publish
            } "Failed to publish to npm"
        }
    }
    end {}
}
