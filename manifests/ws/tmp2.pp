
class ws::tmp2 {
    
	$qutoa_package = $::operatingsystem ? {
		/(Archlinux)/		=> 'quota-tools',
	}

	package { $quota_package:
		ensure	=> 'latest'
	}

}
