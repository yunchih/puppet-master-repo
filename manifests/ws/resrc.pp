class ws::resrc {
	package { 'python-resrc':
		ensure => 'present'
	}

	$oasis_servers = hiera("ws::resrc::oasis")

	if $trusted['certname'] in $oasis_servers  {
		$config_name = 'oasis'
	} else {
		$config_name = 'linux'
	}

	file { "/etc/resrc/$config_name.yaml":
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/resrc/$config_name.yaml"
	}

	service { "resrc@$config_name":
		ensure	=> 'running',
		enable  => true
	}
}
