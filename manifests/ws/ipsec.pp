

class ws::ipsec {

	$ipsec_package = $::operatingsystem ? {
		default	=> 'ipsec-tools'
	}

	package { $ipsec_package:
		ensure	=> 'present'
	}

	$agent = $trusted['certname']
	file { '/etc/ipsec.conf':
		ensure	=> file,
		owner 	=> '0',
		group 	=> '0',
		mode	=> '0400',
		source	=> "puppet:///wslab/217-base/ipsec/${agent}/ipsec-tools.conf"
	}

	service { "ipsec":
		ensure	=> 'running'
	}
}
