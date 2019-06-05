# puppet-windows-sample

This is just me trying to come up with some samples for Puppet managed windows servers.

Mostly to make some notes for myself, but it's even better if someone else finds it useful.

I did not find concrete and complete examples of a whole environment with site manifest, hiera, roles and profiles so just started to put things together based on the docs and various blogs.

For windows my plan is to use PowerShell DSC mainly.  
This requires that we have a the necessary PowerShell DSC resource modules installed, so there is some bootstrapping of that.

## Features

* Chocolatey based default software packages
* Adding Nuget package provider
* PowerShell gallery package install
* Some kind of concept of patching during maintanance window from Microsoft update
* reboot 