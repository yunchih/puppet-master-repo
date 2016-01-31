class ws::fail2ban {

	$package = $::operatingsystem ? {
		default	=> 'fail2ban'
	}

	package { $package:
		ensure	=> 'present'
	}

	file { '/etc/fail2ban':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/fail2ban'
	}

	service { "fail2ban.service":
		ensure	=> 'running'
	}
}
