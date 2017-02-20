########################################################
##
## TypeScript.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## TypeScript commands
##
#######################################################

function Clear-TSBuild
{
<#
.SYNOPSIS

Clears Typescript project

.DESCRIPTION

Clear-TSBuild clears Typescript project build

.PARAMETER Path

Path to Typescript project (default: .)

.EXAMPLE

PS> Clear-TSBuild -Path .

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
        if (Test-Path -Path 'tsconfig.json')
        {
            $c = Get-Content -Path 'tsconfig.json' | ConvertFrom-Json
            $cp = $c.compilerOptions.outDir

            if (Test-Path -Path $cp)
            {
                Remove-Item -Path $cp -Recurse -Force
            }
        }
    }
    end {}
}


function Invoke-TSBuild
{
<#
.SYNOPSIS

Builds Typescript project

.DESCRIPTION

Invoke-TSBuild builds Typescript project in specified configuration

.PARAMETER Path

Path to Typescript project (default: .)

.EXAMPLE

PS> Invoke-TSBuild -Path .

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
                & tsc
            } "Build with Typescript failed"
        }
    }
    end {}
}


function Invoke-TSRebuild
{
<#
.SYNOPSIS

Rebuilds Typescript project

.DESCRIPTION

Invoke-TSRebuild rebuilds Typescript project in specified configuration

.PARAMETER Path

Path to Typescript project (default: .)

.EXAMPLE

PS> Invoke-TSRebuild -Path .

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
        Clear-TSBuild -Path $Path
        Invoke-TSBuild -Path $Path
    }
    end {}
}


function Watch-TSBuild
{
<#
.SYNOPSIS

Watches for changes in Typescript project build

.DESCRIPTION

Watch-TSBuild watches for changes in Typescript project and builds

.PARAMETER Path

Path to Typescript project (default: .)

.EXAMPLE

PS> Watch-TSBuild -Path .

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
                & tsc --watch
            } "Project watch with Typescript failed"
        }
    }
    end {}
}
