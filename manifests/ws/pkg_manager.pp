
class ws::pkg_manager {
	if $operatingsystem == 'Archlinux' {

		$repo = {
			'core'		=> { order => 10, },
			'extra'		=> { order => 20, },
			'community'	=> { order => 30, },
			'multilib'	=> { order => 40, },
		}

		class { 'pacman':
			always_refresh 	=> false,
			repositories	=> $repo,
		}


		$aur = hiera("ws::arch::aur")
		pacman::repo { $aur['name']:
		    server	=> $aur['server'],
		    sig_level	=> $aur['sig_level'],
		    order	=> 50,
		}

		file { '/etc/pacman.d/mirrorlist':
			ensure	=> file,
			source	=> "puppet:///$environment/217-base/etc/pacman.d/mirrorlist"
		}

	}
}

