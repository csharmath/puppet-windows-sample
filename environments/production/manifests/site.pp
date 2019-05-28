node default {
  notify { example :
    message => 'Puppet, are you here?',
  }

  file { 'c:\file.txt':
    ensure => file,
    owner  => 'Administrator',
    group  => 'Users',
    mode   => '0644',
  }

  $packages = ['git', 'sysinternals']
  package {$packages:
    ensure   => present,
    provider => 'chocolatey',
  }

  pspackageprovider {'Nuget':
    ensure => present,
  }

  psrepository { 'PSGallery':
    ensure              => present,
    source_location     => 'https://www.powershellgallery.com/api/v2/',
    installation_policy => 'trusted',
  }

  $powershell_packages = ['xPSDesiredStateConfiguration','PSWindowsUpdate','ComputerManagementDsc']

  package {$powershell_packages:
    ensure   => latest,
    provider => 'windowspowershell',
    source   => 'PSGallery',
  }

  # dsc {'timezone':
  #   resource_name => 'TimeZone',
  #   module        => 'ComputerManagementDsc',
  #   properties    => {
  #     IsSingleInstance => 'Yes',
  #     TimeZone   => 'Eastern Standard Time',
  #   }

  exec {'Set Timezone':
    command => 'Set-TimeZone -Id "Eastern Standard Time"',
    unless => 'if ((Get-TimeZone).Id -ne "Eastern Standard Time") { exit 1 }',
    provider => powershell,
  }

  exec {'configure windows update':
    command  => 'Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d',
    onlyif   => 'if ($null -ne (Get-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d)) {exit 1}',
    provider => powershell,
  }

  schedule {'nightly':
    period => daily,
    range  => '23-4',
  }

  exec {'Install windows updates':
    command => 'Get-WUInstall –MicrosoftUpdate –AcceptAll –IgnoreReboot',
    provider => powershell,
    schedule => 'nightly'
  }

  reboot { 'reboot when pending':
      when    => pending,
  }
}
