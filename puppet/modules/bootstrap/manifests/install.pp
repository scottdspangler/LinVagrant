
class bootstrap::install {

    Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/sbin:/usr/local/bin" }
    exec { 

        # External Modules Nginx, Mysql
        #'Puppetlabs-Nginx':
        #    command => "puppet module install puppetlabs-nginx --modulepath /etc/puppet/modules",
        #    creates => "/etc/puppet/modules/nginx",
        #    require => Exec[ 'SetHostname' ];

        # Flush Stale Caches (Takes forever)
        'Flush Apt-Cache':
            command => "$bootstrap::params::flushRepos", 
            timeout => 1800;

        'Puppetlabs-Mysql':
            command => "puppet module install puppetlabs-mysql --modulepath /etc/puppet/modules",
            creates => "/etc/puppet/modules/mysql",
            require => Exec[ "Flush Apt-Cache" ];

        'Puppetlabs-Firewall':
            command => "puppet module install puppetlabs-firewall --modulepath /etc/puppet/modules",
            creates => "/etc/puppet/modules/firewall",
            require => Exec[ "Puppetlabs-Mysql" ];
        
    }

    # Base Packages
    package {
        'VIM':
            name    => $bootstrap::params::vim_pkg,
            require => Exec[ 'Puppetlabs-Firewall' ];

        'GIT':
            name    => $bootstrap::params::git_pkg, 
            require => Package[ 'VIM' ];

        'SETUPTOOLS':
            name    => $bootstrap::params::pys_pkg,
            require => Package[ 'GIT' ];

        'PIP':
            name    => $bootstrap::params::pip_pkg, 
            require => Package[ 'SETUPTOOLS' ];

        'TZDATA':
            name    => $bootstrap::params::tzd_pkg,
            require => Package[ 'PIP' ];
    }

    # Update virtual tools if applicable
    if $bootstrap::is_virtual == 'true' {

        package {
            'VBOX-UTILS':
                ensure  => installed,
                name    => 'virtualbox-guest-utils',
                require => Package[ 'TZDATA' ];
        }

    }

}
