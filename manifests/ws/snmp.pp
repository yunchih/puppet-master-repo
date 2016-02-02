class ws::snmp {

	$package = $::operatingsystem ? {
		default	=> 'net-snmp'
	}

	package { $package:
		ensure	=> 'present'
	}

	file { '/etc/snmp':
		ensure	=> directory,
		uid 	=> '0',
		gid 	=> '0',
		mode	=> '0644',
	}

	file { '/etc/snmp/snmpd.conf':
		ensure	=> file,
		uid 	=> '0',
		gid 	=> '0',
		mode	=> '0600',
		source	=> 'puppet:///wslab/217-base/etc/snmp/snmpd.conf'
	}

	service { "snmpd":
		ensure	=> 'running'
	}
}
