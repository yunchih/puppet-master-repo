class ws::mail {
	
	$nfs_package = $::operatingsystem ? {
		default			=> 'exim'
	}
	
	$exim_service = "exim"

	package { $nfs_package:
		ensure	=> 'present'
	}

	file { [ '/etc/mail', '/etc/mail/ssl']:
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
		source	=> "puppet:///$environment/217-base/etc/mail/exim.conf"
	}

	file { "/etc/mail/ssl/exim.crt":
		ensure	=> file,
		owner	=> '0',
		group	=> '0',
		mode	=> '400',
		source	=> "puppet:///$environment/217-base/etc/mail/ssl/exim.crt"
	}

	file { "/etc/mail/ssl/exim.pem":
		ensure	=> file,
		owner	=> '0',
		group	=> '0',
		mode	=> '444',
		source	=> "puppet:///$environment/217-base/etc/mail/ssl/exim.pem"
	}

    # workaround /bin/mail error message since s-nail 14.9.0-1
    file_line { 'mailrc':
        ensure => present,
        path   => '/etc/mail.rc', line   => 'unset emptystart',
        match  => '^set\ emptystart',
    }

	service { $exim_service:
		ensure	=> 'running'
	}

}


