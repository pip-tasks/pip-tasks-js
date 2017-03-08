########################################################
##
## Bower.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Bower commands
##
#######################################################

function Get-BowerVersion
{
<#
.SYNOPSIS

Gets version of Bower project

.DESCRIPTION

Get-BowerVersion gets version of Bower project

.PARAMETER Path

Path to Bower project (default: .)

.EXAMPLE

PS> Get-BowerVersion -Path .

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
            if (Test-Path -Path bower.json)
            {
                $pkg = Get-Content -Path bower.json | ConvertFrom-Json
                Write-Output $pkg.version
            }
        }
    }
    end {}
}


function Set-BowerVersion
{
<#
.SYNOPSIS

Sets version of Bower project

.DESCRIPTION

Set-BowerVersion sets version of Bower project

.PARAMETER Path

Path to Bower project (default: .)

.PARAMETER Version

New version of the Bower project

.EXAMPLE

PS> Get-BowerVersion -Path .

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
            if (Test-Path -Path bower.json)
            {
                $pkg = Get-Content -Path bower.json | ConvertFrom-Json
                $pkg.version = $Version
                $pkg | ConvertTo-Json | Set-Content -Path bower.json
            }
        }
    }
    end {}
}


function Get-BowerDependencies
{
<#
.SYNOPSIS

Gets all Bower dependencies

.DESCRIPTION

Get-BowerDependencies gets all Bower dependencies and their versions

.PARAMETER Path

Path to Bower project (default: .)

.EXAMPLE

PS> Get-BowerDependencies -Path .

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
            if (Test-Path -Path bower.json)
            {
                $pkg = Get-Content -Path bower.json | ConvertFrom-Json

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

function Install-BowerDependencies
{
<#
.SYNOPSIS

Installs Bower dependencies

.DESCRIPTION

Install-BowerDependencies installs Bower dependencies

.PARAMETER Path

Path to Bower project (default: .)

.EXAMPLE

PS> Install-BowerDependencies -Path .

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

Update-BowerDependency updates version of Bower dependency

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
            if (Test-Path -Path bower.json)
            {
                $pkg = Get-Content -Path bower.json | ConvertFrom-Json

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

                ConvertTo-Json -InputObject $pkg | Set-Content -Path bower.json
            }
        }
    }
    end {}
}
