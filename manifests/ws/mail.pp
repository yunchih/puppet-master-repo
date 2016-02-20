class ws::mail {
	
	$nfs_package = $::operatingsystem ? {
		default			=> 'exim'
	}
	
	$exim_service = "exim"

	package { $nfs_package:
		ensure	=> 'present'
	}

	file { [ '/etc/mail']:
		ensure	=> directory,
		owner	=> '0',
		group	=> '0',
		mode	=> '644',
	}

	file { "/etc/mail/exim.conf":
		ensure	=> file,
		notify  => Service[$exim_service],
		owner	=> '0',
		group	=> '0',
		mode	=> '644',
		source	=> "puppet:///wslab/217-base/etc/mail/exim.conf"
	}

	service { $exim_service:
		ensure	=> 'running'
	}

}


