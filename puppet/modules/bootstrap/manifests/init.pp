

class bootstrap ( $host         = "", 
                  $domain       = "", 
                  $nameservers  = "", 
                  $alt_hosts    = "", 
                  $alt_doms     = "",
                  $resolvTemp   = "", 
                  $hostsTemp    = "",
                  $is_virtual   = 'true' ) {

    include bootstrap::params, bootstrap::install, bootstrap::config, bootstrap::service

}
