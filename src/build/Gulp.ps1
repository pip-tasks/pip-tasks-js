########################################################
##
## Gulp.ps1
## Pip.Tasks.JS - Javascript and Node.js build tasks for Pip.Tasks
## Gulp commands
##
#######################################################


function Clear-GulpBuild
{
<#
.SYNOPSIS

Clears Gulp project build

.DESCRIPTION

Clear-GulpBuild clears Gulp project build

.PARAMETER Path

Path to Gulp project (default: .)

.EXAMPLE

PS> Clear-GulpBuild -Path .

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
                & gulp clean
            } "Cleaning Gulp build failed"
        }
    }
    end {}
}


function Invoke-GulpBuild
{
<#
.SYNOPSIS

Builds Gulp project

.DESCRIPTION

Invoke-Gulp builds Gulp project in specified configuration

.PARAMETER Path

Path to Gulp project (default: .)

.EXAMPLE

PS> Invoke-GulpBuild -Path .

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
                & gulp build
            } "Build with Gulp failed"
        }
    }
    end {}
}


function Invoke-GulpRebuild
{
<#
.SYNOPSIS

Rebuilds Gulp project

.DESCRIPTION

Invoke-Gulp rebuilds Gulp project in specified configuration

.PARAMETER Path

Path to Gulp project (default: .)

.EXAMPLE

PS> Invoke-GulpRebuild -Path .

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
                & gulp rebuild
            } "Build project with Gulp failed"
        }
    }
    end {}
}


function Watch-GulpBuild
{
<#
.SYNOPSIS

Watches for changes in Gulp project build

.DESCRIPTION

Watch-GulpBuild watches for changes in Gulp project and builds

.PARAMETER Path

Path to Gulp project build (default: .)

.EXAMPLE

PS> Watch-GulpBuild -Path .

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
                & gulp watch
            } "Project watch with Gulp failed"
        }
    }
    end {}
}
