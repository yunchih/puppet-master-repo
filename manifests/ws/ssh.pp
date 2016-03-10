class ws::ssh {
	package { 'openssh':
		ensure => 'latest'
	}

	service { 'sshd':
		ensure	=> 'running'
	}

	$ws_with_extra_ports = hiera("ws::ssh::open_extra_ports")

    if $trusted['certname'] in $ws_with_extra_ports {
        $source = "puppet:///wslab/217-base/etc/ssh/sshd_config_extra_ports"
    }
    else {
        $source = "puppet:///wslab/217-base/etc/ssh/sshd_config"
    }

    file { '/etc/ssh/sshd_config':
        notify	=> Service['sshd'],
        owner	=> 0,
        group	=> 0,
        mode	=> '0644',
        source  => $source
    }

}
