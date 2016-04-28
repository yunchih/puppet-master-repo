
class ws::logrotate {

	$package = "logrotate"
    $service = "logrotate.timer"

	package { $package:
		ensure	=> 'present'
	}

    file { "/etc/logrotate.d":
        ensure	=> directory,
    }

	$systemd_timer = $::operatingsystem ? {
        default	=> "/usr/lib/systemd/system/logrotate.timer"
	}

    file { $systemd_timer:
        ensure	=> file,
        notify	=> Service["logrotate.timer"],
        source	=> "puppet:///wslab/217-base/usr/lib/systemd/system/logrotate.timer"
    }

	service { $service:
        ensure  => 'running',
        enable  => 'true',
	}

}

