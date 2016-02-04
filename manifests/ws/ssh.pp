class ws::ssh {
    package { 'openssh':
        ensure => 'present'
    }
	
	service { 'sshd:
		ensure	=> 'running'
	}
}
