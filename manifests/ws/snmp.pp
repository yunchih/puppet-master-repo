class ws::snmp {

	$package = $::operatingsystem ? {
		default	=> 'net-snmp'
	}

	package { $package:
		ensure	=> 'present'
	}

	service { "snmpd":
		ensure	=> 'running'
	}

	file { '/etc/snmp':
		ensure	=> directory,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
	}

	file { '/etc/snmp/snmpd.conf':
		ensure	=> file,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0600',
		source	=> 'puppet:///wslab/217-base/etc/snmp/snmpd.conf'
	}
}
