class ws::iptables {
	file { '/etc/sysconfig/iptables':
		ensure => 'link',
		target => '/etc/iptables/empty.rules'
	}
	class { 'iptables':
	}
}
