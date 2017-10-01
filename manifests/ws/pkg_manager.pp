
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


		$custom_repos = [ "ws::arch::aur", "ws::arch::wsarch" ]
		$custom_repos.each |$r| {
			$aur = hiera($r)
			pacman::repo { $aur['name']:
			    server	=> $aur['server'],
			    sig_level	=> $aur['sig_level'],
			    order	=> $aur['order'],
			}
		}

		file { '/etc/pacman.d/mirrorlist':
			ensure	=> file,
			source	=> "puppet:///$environment/217-base/etc/pacman.d/mirrorlist"
		}

	}
}

