class ws::ssh {
	package { 'openssh':
		ensure => 'latest'
	}

	service { 'sshd':
		ensure	=> 'running'
	}

	file { '/etc/ssh/sshd_config':
		notify	=> Service['sshd'],
		owner	=> 0,
		group	=> 0,
		mode	=> '0644',
		source  => 'puppet:///wslab/217-base/etc/ssh/sshd_config'
	}

}
