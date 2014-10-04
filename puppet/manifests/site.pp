/***
 *
 * Silly Ttack
 *
 ********/

node /^vagrant-ubuntu$^vagrant.*$/ {

  exec { 'apt-get update':
    path => '/usr/bin',
  }

  package { "apache2":
    ensure  => present,
    require => Exec[ "apt-get update" ], 
  }

}
