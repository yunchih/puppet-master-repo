class ws::at {

	$at_package = $::operatingsystem ? {
		default	=> 'at'
	}

	package { $at_package:
		ensure	=> 'present'
	}

	service { 'atd':
		ensure	=> 'running'
	}
}
