
class ws::pkg_manager {
	if $operatingsystem == 'Archlinux' {

		$repo = {
			'core'		=> { order => 10, },
			'extra'		=> { order => 20, },
			'community'	=> { order => 30, },
			'multilib'	=> { order => 40, },
		}

		class { 'pacman':
			repositories	=> $repo,
		}


		$mirror = hiera("ws::pacman::mirror")
		pacman::repo { $mirror['name']:
		    server	=> $mirror['server'],
		    sig_level	=> $mirror['sig_level'],
		    order	=> 50,
		}

		file { '/etc/pacman.d/mirrorlist':
			ensure	=> file,
			source	=> "puppet:///wslab/217-base/etc/pacman.d/mirrorlist"
		}

	  	exec { 'pacman-full-upgrade':
			command		=> "/root/pacman-full-upgrade.sh",
			logoutput	=> "true",
			timeout		=> 1200
	  	}
	}
}

