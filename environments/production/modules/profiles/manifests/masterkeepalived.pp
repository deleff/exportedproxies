class profiles::masterkeepalived     ( $portnum = hiera('apacheport'),
                                       $vip = hiera('virtualip') ) {

include keepalived

keepalived::vrrp::script { 'check_haproxy':
    script => 'killall -0 haproxy',
  }


  keepalived::vrrp::instance { 'VI_50':
    interface         => 'eth1',
    state             => 'MASTER',
    virtual_router_id => '50',
    priority          => '101',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => [ "${vip}" ],
    track_interface   => ['eth1','tun0'], # optional, monitor these interfaces.
    track_script      => 'check_haproxy',  
    unicast_peers     => ['10.90.15.105', '10.90.15.110']

}

}
