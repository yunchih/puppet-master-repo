
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
	}

}
