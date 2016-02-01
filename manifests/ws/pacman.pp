
class ws::pacman {
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
        pacman::repo { mirror['name']:
            server => mirror['server'],
            order  => 50,
        }
	}

}
