class ws::ssh {
	class { 'ssh':
		server_options => {
			'PermitRootLogin' => 'yes',
			'PasswordAuthentication' => 'yes'
		}
	}
	
}
