class ws::ssh {
    package { 'openssh':
        ensure => 'latest'
    }
	
	service { 'sshd':
		ensure	=> 'running'
	}
}
