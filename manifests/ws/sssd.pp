class ws::sssd {
	package { 'sssd':
		ensure => 'present'
	}

	service { 'sssd':
		ensure	=> 'running',
        enable  => true
	}

    file { '/etc/sssd/sssd.conf':
        notify	=> [Service['sssd']],
        owner	=> 0,
        group	=> 0,
        mode	=> '0600',
		source	=> "puppet:///$environment/217-base/etc/sssd/sssd.conf"
    }

}
