

class ws::sudo {
	
	
	$sudo_package = $::operatingsystem ? {
		"Archlinux"	=> ['sudo'],
	}

	package { $sudo_package:
		ensure	=> 'present'
	}

	file { ['/etc/sudoers.d']:
		ensure	=> directory,
		recurse	=> remote,
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/sudoers.d"
	}

    file { "/etc/sudoers-lecture":
        ensure	=> file,
        mode	=> '0444',
        source	=> "puppet:///$environment/217-base/etc/sudoers-lecture"
    }
	

}
