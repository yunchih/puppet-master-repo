class ws::munin {

	$munin_package = $::operatingsystem ? {
		default	=> 'munin-node'
	}

	package { $munin_package:
		ensure	=> 'present'
	}

	file { '/etc/munin':
		ensure	=> directory,
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
	}

	file { '/etc/munin/munin-node.conf':
		ensure	=> file,
		notify	=> Service['munin-node'],
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/munin/munin-node.conf"
	}

	## plugins
	exec { 'load munin plugins':
		path	=> '/usr/bin:/usr/sbin:/bin',
		onlyif	=> 'test -n "$(find /etc/munin/plugins -maxdepth 0 -empty)"',
		command	=> 'munin-node-configure --shell | sh'
	}

	service { 'munin-node':
		ensure	=> 'running'
	}
}
