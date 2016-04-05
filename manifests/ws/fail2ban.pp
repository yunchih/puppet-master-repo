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
		notify	=> Service["fail2ban.service"],
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/fail2ban'
    }

	file { '/etc/logrotate.d/fail2ban':
		ensure	=> file,
		notify	=> Service["fail2ban.service"],
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/logrotate.d/fail2ban'
    }

	file { '/etc/systemd/system/fail2ban.service.d':
		ensure	=> directory,
		recurse	=> remote,
		notify	=> Service["fail2ban.service"],
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/systemd/system/fail2ban.service.d'
    }

	service { "fail2ban.service":
		ensure	=> 'running'
	}
}
