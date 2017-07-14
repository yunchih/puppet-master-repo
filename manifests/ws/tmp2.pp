
class ws::tmp2 {
    
	$quota_package = $::operatingsystem ? {
		/(Archlinux)/		=> 'quota-tools',
	}

	package { $quota_package:
		ensure	=> 'present'
	}

    file { "/tmp2":
        ensure	=> directory,
        owner	=> '0',
        group	=> '0',
        mode	=> '1777'
    }

}
