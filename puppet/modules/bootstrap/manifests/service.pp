
class bootstrap::service {

    service {
        'RPC.STATD':
            name   => "nfs-common",
            ensure => stopped,
            enable => false;

        'RPCBIND':
            name   => 'rpcbind',
            ensure => stopped,
            enable => false;
    }
}
