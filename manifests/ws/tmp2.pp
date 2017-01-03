
class ws::tmp2 {
    
	$quota_package = $::operatingsystem ? {
		/(Archlinux)/		=> 'quota-tools',
	}

	package { $quota_package:
		ensure	=> 'present'
	}

}
