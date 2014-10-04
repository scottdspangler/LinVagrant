
class bootstrap::config {

    $host         = $bootstrap::host
    $domain       = $bootstrap::domain
    $nameservers  = $bootstrap::nameservers
    $fqdn         = "$bootstrap::host.$bootstrap::domain"

    File { owner => root, group => root, mode => 0644 }
    file {

        'ServerTime':
            ensure  => file,
            path    => '/etc/timezone',
            content => 'Etc/UTC',
            require => Package[ 'tzdata' ];

        'LocalTime':
            ensure  => link,
            path    => '/etc/localtime',
            target  => '/usr/share/zoneinfo/UTC',
            require => File[ 'ServerTime' ];

        'HostName':
            ensure  => file,
            path    => '/etc/hostname',
            content => "$fqdn",
            require => File[ 'LocalTime' ];

        'Resolving':
            ensure  => file,
            path    => "/etc/resolv.conf",
            content => template( $bootstrap::resolvTemp ), 
            require => File[ 'HostName' ];

        'HostsFile':
            ensure  => file,
            path    => "/etc/hosts",
            content => template( $bootstrap::hostsTemp ), 
            require => File[ "Resolving" ];
    }

    Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/sbin:/usr/local/bin" }
    exec {
        'SetHostname':
            command => "/bin/hostname -F /etc/hostname",
            require => File[ 'HostsFile' ];
    }
}
