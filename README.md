# puppet-windows-sample

This is just me trying to come up with some samples for Puppet managed windows servers.

Mostly to make some notes for myself, but it's even better if someone else finds it useful.

I did not find concrete and complete examples of a whole environment with site manifest, hiera, roles and profiles so just started to put things together based on the docs and various blogs.

For windows my plan is to use PowerShell DSC mainly.  
This requires that we have a the necessary PowerShell DSC resource modules installed, so there is some bootstrapping of that.

As per patching, I am just experimenting with Puppet's schedule meta property to define a work window for patches and connecting windows update with some magic guid to actually patch.
