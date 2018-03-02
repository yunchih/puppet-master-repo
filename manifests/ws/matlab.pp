
class ws::matlab {
	
	file { '/usr/bin/matlab':
		ensure	=> 'link',
		target	=> '/usr/local/matlab/bin/matlab'
	}	

	file { '/usr/local/matlab':
		ensure	=> 'link',
		target	=> '/nfs/linux/matlab'
	}	

	package { "ncurses5-compat-libs":
		ensure	=> 'present'
	}

}
