class ws::nscd {

	$nscd_package = $::operatingsystem ? {
		"Archlinux"	=> 'glibc'
	}
	$nscd_service = $::operatingsystem ? {
		default		=> 'nscd.service'
	}

	package { $nscd_package:
		ensure		=> 'present'
	}
	service { $nscd_service:
		ensure		=> 'running',
        enable      => true
	}
}
