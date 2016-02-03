

class ws::ipsec {


}
class ws::snmp {

	$package = $::operatingsystem ? {
		default	=> 'ipsec-tools'
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

	$agent = $trusted['certname']
	file { '/etc/ipsec.conf':
		ensure	=> file,
		uid 	=> '0',
		gid 	=> '0',
		mode	=> '0400',
		source	=> 'puppet:///wslab/217-base/ipsec/${agent}/ipsec.conf'
	}

	service { "ipsec":
		ensure	=> 'running'
	}
}
