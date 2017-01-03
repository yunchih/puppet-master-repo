
class ws::systemd {
	file { '/etc/systemd/journald.conf':
        owner	=> 0,
        group	=> 0,
        mode	=> '0644',
        source  => "puppet:///$environment/217-base/etc/systemd/journald.conf"
	}

	file { '/etc/systemd/user.conf':
        owner	=> 0,
        group	=> 0,
        mode	=> '0644',
        source  => "puppet:///$environment/217-base/etc/systemd/user.conf"
	}
}
