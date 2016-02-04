class ws::snmp {

	$snmp_package = $::operatingsystem ? {
		default	=> 'net-snmp'
	}

	package { $snmp_package:
		ensure	=> 'present'
	}

	file { '/etc/snmp':
		ensure	=> directory,
		owner		=> '0',
		group		=> '0',
		mode	=> '0644',
	}

	file { '/etc/snmp/snmpd.conf':
		ensure	    => file,
        notify      => Service["snmpd"],
		owner		=> '0',
		group		=> '0',
		mode	=> '0600',
		source	=> 'puppet:///wslab/217-base/etc/snmp/snmpd.conf'
	}

	service { "snmpd":
		ensure	=> 'running'
	}
}
