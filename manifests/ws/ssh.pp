class ws::ssh {
	package { 'openssh':
		ensure => 'present'
	}

	service { 'sshd':
		ensure	=> 'running',
        enable  => true
	}

	$extra_ports_servers = hiera("ws::ssh::extra_ports::servers")
	$extra_ports_list = hiera("ws::ssh::extra_ports")

    $fbase = hiera("master::file_base")
    $source = "${fbase}/${environment}/217-base/etc/ssh/sshd_config"
    if $trusted['certname'] in $extra_ports_servers  {
        $extra_ports = join($extra_ports_list.map |$p| { "Port ${p}" }, "\n")
    }

    $ban_list = join(hiera("ws::ssh::ban_list")," ")
    $sshd_config = join([file($source), "${extra_ports}", "DenyUsers ${ban_list}\n"], "\n")

    file { '/etc/ssh/sshd_config':
        notify	=> Service['sshd'],
        owner	=> 0,
        group	=> 0,
        mode	=> '0644',
        content  => $sshd_config
    }

    file { "/etc/systemd/system/sshd.service.d/":
	ensure	=> directory,
	owner	=> '0',
	group	=> '0',
	mode	=> '0755',
	source	=> "puppet:///$environment/217-base/etc/systemd/system/sshd.service.d/"
    }
    file { "/etc/systemd/system/sshd.service.d/10-CPUWeight.conf":
	ensure	=> file,
	owner	=> '0',
	group	=> '0',
	mode	=> '0644',
	source	=> "puppet:///$environment/217-base/etc/systemd/system/sshd.service.d/10-CPUWeight.conf"
    }
    file { "/etc/systemd/system/sshd.service.d/50-MemoryLow.conf":
	ensure	=> file,
	owner	=> '0',
	group	=> '0',
	mode	=> '0644',
	source	=> "puppet:///$environment/217-base/etc/systemd/system/sshd.service.d/50-MemoryLow.conf"
    }
}
