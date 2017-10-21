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

    file { "/etc/logrotate.d/sssd":
        ensure	=> file,
        owner	=> '0',
        group	=> '0',
        mode	=> '644',
        source	=> "puppet:///$environment/217-base/etc/logrotate.d/sssd"
    }
    file { "/etc/systemd/system/sssd.service.d/":
	ensure	=> directory,
	owner	=> '0',
	group	=> '0',
	mode	=> '0755',
	source	=> "puppet:///$environment/217-base/etc/systemd/system/sssd.service.d/"
    }
    file { "/etc/systemd/system/sssd.service.d/20-Restart_always.conf":
	ensure	=> file,
	owner	=> '0',
	group	=> '0',
	mode	=> '0644',
	source	=> "puppet:///$environment/217-base/etc/systemd/system/sssd.service.d/20-Restart_always.conf"
    }
    file { "/etc/systemd/system/sssd.service.d/50-CPUWeight.conf":
	ensure	=> file,
	owner	=> '0',
	group	=> '0',
	mode	=> '0644',
	source	=> "puppet:///$environment/217-base/etc/systemd/system/sssd.service.d/50-CPUWeight.conf"
    }
    file { "/etc/systemd/system/sssd.service.d/50-MemoryLow.conf":
	ensure	=> file,
	owner	=> '0',
	group	=> '0',
	mode	=> '0644',
	source	=> "puppet:///$environment/217-base/etc/systemd/system/sssd.service.d/50-MemoryLow.conf"
    }
}
