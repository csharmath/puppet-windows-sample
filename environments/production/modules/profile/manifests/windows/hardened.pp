# Warning! This is not a complete security hardening solution!
# Sample hardening steps! Rest is usually done via security baseline GPO's. 
# Standalon servers should apply local secpol settings based on security baseline GPO's
#
# what it does:
# Disable unnecessary services
# Disable Guest account
class profile::windows::hardened(
  Array[String] $services_not_needed,
){
  service {$services_not_needed:
    ensure => 'stopped',
    enable => false,
  }

  dsc_user { 'Guest':
    dsc_username  => 'Guest',
    dsc_disabled  => 'true',
  }
}
