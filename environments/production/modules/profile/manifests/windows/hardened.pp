# Sample hardening steps. Rest is usually done via security baseline GPO's
# Disable unnecessary services
# Disable Guest account
class profile::windows::hardened(
  Array[String] $services_not_needed,
){
  service {$services_not_needed:
    ensure => 'stopped',
    enable => false,
  }

  user { 'Guest':
    ensure  => 'absent',
  }
}
