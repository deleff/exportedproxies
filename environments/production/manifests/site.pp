
node 	'http1.example.haproxy',
	'http2.example.haproxy' {
include roles::apacheproject
}

node 'proxy1.example.haproxy' {
include roles::masterproxy
}


node 'proxy2.example.haproxy' {
include roles::backupproxy
}


node default {

}
