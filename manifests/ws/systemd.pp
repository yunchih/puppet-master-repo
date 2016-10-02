
class ws::systemd {
	file { '/etc/systemd/journald.conf':
        owner	=> 0,
        group	=> 0,
        mode	=> '0644',
        source  => "puppet:///$environment/217-base/etc/systemd/journald.conf"
	}
}