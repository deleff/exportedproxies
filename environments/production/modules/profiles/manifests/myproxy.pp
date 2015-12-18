class profiles::myproxy ( $portnum = hiera('apacheport'),
                          $vip = hiera('virtualip')  ) {


class { 'haproxy': }
 haproxy::listen { 'puppet01':
    collect_exported => false,
    ipaddress        => $vip,
     ports            => "${portnum}",
     options         => {
        'mode'       => 'http',
            },
          }

 # collect all of the balancer members
    Haproxy::Balancermember <<| listening_service == 'puppet01' |>>

 # disable the appropriate firewalls
   firewall { '100 allow http and https access':
    dport   => [80, 443, 61613, 8140, $portnum],
    proto  => tcp,
    action => accept,
  }

 # enable forwarding
   sysctl::value { "net.ipv4.ip_forward": value => "1" }

   sysctl::value { "net.ipv4.ip_nonlocal_bind": value => "1" }


}
