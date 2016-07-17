
class ws::iptables {

	$package = "iptables"
    $service = "iptables.service"

	package { $package:
		ensure	=> 'present'
	}

    file { "/etc/iptables":
        ensure	=> directory,
    }

    file { "/etc/iptables/iptables.rules":
        ensure	=> file,
        notify  => Service[$service],
        owner	=> '0',
        group	=> '0',
        mode	=> '600',
        source	=> "puppet:///wslab/217-base/etc/iptables/iptables.rules"
    }

	service { $service:
		ensure	=> 'running',
        enable  => true
	}
}
