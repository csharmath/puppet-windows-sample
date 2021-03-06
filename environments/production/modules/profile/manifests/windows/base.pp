class profile::windows::base(
  Array[String] $packages = ['git', 'sysinternals'],
  Array[String] $powershell_packages = ['xPSDesiredStateConfiguration','PSWindowsUpdate','ComputerManagementDsc'],
  String $timezone = 'Eastern Standard Time',
) {

    # install some default software packages like git and sysinternals
    package { $packages:
      ensure   => present,
      provider => 'chocolatey',
    }

    pspackageprovider {'Nuget':
      ensure => present,
    }

    # setup powershell gallery as trusted source
    psrepository { 'PSGallery':
      ensure              => present,
      source_location     => 'https://www.powershellgallery.com/api/v2/',
      installation_policy => 'trusted',
    }

    # install powershell modules (mostly DSC)
    package { $powershell_packages:
      ensure   => latest,
      provider => 'windowspowershell',
      source   => 'PSGallery',
    }

    # 
    dsc {'timezone':
      resource_name => 'TimeZone',
      module        => 'ComputerManagementDsc',
      properties    => {
        isSingleInstance => 'Yes',
        timeZone         => $timezone,
      }
    }

    exec {'configure windows update':
      command  => 'Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d',
      onlyif   => 'if ($null -ne (Get-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d)) {exit 1}',
      provider => powershell,
    }

    schedule { 'nightly':
      period => daily,
      range  => '0-3',
      repeat => 3,
    }

    exec {'Install windows updates':
      command  => 'Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot',
      provider => powershell,
      schedule => 'nightly'
    }

    reboot { 'reboot when pending':
        when     => pending,
        schedule => 'nightly'
    }
}
