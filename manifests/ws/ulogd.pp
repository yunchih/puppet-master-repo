
class ws::ulogd {

	$package = "ulogd"
    $service = "ulogd.service"

	package { $package:
		ensure	=> 'present'
	}

    file { "/etc/ulogd.conf":
        ensure	=> file,
        notify  => Service[$service],
        owner	=> '0',
        group	=> '0',
        mode	=> '644',
        source	=> "puppet:///wslab/217-base/etc/ulogd.conf"
    }

    file { "/etc/logrotate.d":
        ensure	=> directory,
    }

    file { "/etc/logrotate.d/ulogd":
        ensure	=> file,
        owner	=> '0',
        group	=> '0',
        mode	=> '644',
        source	=> "puppet:///wslab/217-base/etc/logrotate.d/ulogd"
    }

    file { "/var/log/wslab-packet.log":
        ensure	=> file,
        owner	=> '0',
        group	=> '0',
        mode	=> '400',
    }

	service { $service:
		ensure	=> 'running'
	}

}

