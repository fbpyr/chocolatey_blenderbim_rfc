# chocolatey_blenderbim_rfc

## about
Rfc for blenderbim chocolatey install / uninstall scripts.

* **install** <br>
  It checks for running `blender.exe` and aborts if found, for safe install. <br>
  Specified blenderbim build is pulled (here: `blenderbim-220719-py310-win.zip`) and sha256sum checked after download.   
  The zip file is then unpacked into `"%APPDATA%\Blender Foundation\Blender\{latest_blender_version}\scripts\addons"`.
  Afterwards the addon is enabled by a short call to headless blender.
  `blenderbim` is registered as installed by chocolatey.

* **uninstall** <br>
  It checks for running `blender.exe` and aborts if found, for safe uninstall.
  Addon is disabled by a short call to headless blender.
  `"%APPDATA%\Blender Foundation\Blender\{latest_blender_version}\scripts\addons"` is removed.
  `blenderbim` is registered as uninstalled.

## rationale
Being able to install [BlenderBIM](https://blenderbim.org) with [chocolatey](https://chocolatey.org)  helps to easily deploy the latest version of BlenderBIM. <br>
With a single simple `choco upgrade all` all chocolatey installed packages can be kept up to date <br>
When writing Blender addons depending on BlenderBIM these chocolatey install / uninstall scripts can <br>
ease the deployment of those as well.

## rfc - best case scenario
This repo could be integrated into ifcopenshell blenderbim build process and dynamically push to <br>
chocolatey community repo. (cycle?: every nightly? just weekly? only specific releases?) <br>
That way from a user and deployment perspective it would be trivial to keep up with its rapid development cycle.

## assertions
This rfc currently only focuses on
* installing / updating / uninstalling the latest build
* on win10 64bit
  * with chocolatey preinstalled
  * assumes blender settings in `"%APPDATA%\Blender Foundation\Blender\{latest_blender_version}\scripts\addons"`
  * blender python version of latest blender chocolatey version
* blender chocolatey package is used as dependency

## missing items
* general
  * [ ] comments
  * [ ] review
* fill info in nuspec
  * [ ] owners
  * [ ] icons
  * [ ] mailing list?
  * [ ] release notes?

## trying out this repo locally
As this is currently not pushed to [chocolatey.org](https://chocolatey.org), one can only try this repo locally via: 

* **install** <br>
  from repo directory: <br>
  `choco pack` to create the nupkg package <br>
  `choco install blenderbim -dv -s .  --force`
* **uninstall** <br>
  `choco uninstall blenderbim`

