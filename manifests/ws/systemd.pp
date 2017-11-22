
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

	file { '/etc/tmpfiles.d/systemd.conf':
        owner	=> 0,
        group	=> 0,
        mode	=> '0644',
        source  => "puppet:///$environment/217-base/etc/tmpfiles.d/systemd.conf"
	}

	file { '/etc/systemd/system/var-log-journal.mount':
        owner	=> 0,
        group	=> 0,
        mode	=> '0644',
        source  => "puppet:///$environment/217-base/etc/systemd/system/var-log-journal.mount"
	}

	service { 'var-log-journal.mount':
		ensure	=> 'running',
        enable  => true
	}
}
