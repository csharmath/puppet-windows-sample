class role::ci::server {
  include profile::windows::base
  include profile::windows::hardened
  #include profile::jenkins::master
}
