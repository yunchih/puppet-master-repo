

class ws::cups {


	$packages = $::operatingsystem ? {
		"Archlinux"	=> ['cups', 'ghostscript', 'gsfonts', 'hplip'],
		"FreeBSD"	=> ['cups']
	}

	package { $packages:
		ensure	=> 'present'
	}


	$cups_server_service = "org.cups.cupsd.service"
	$cups_proxy_service = "cups-proxy.service"
	$cups_runtime_dir = "/run/cups"

	file { '/etc/cups':
		ensure	=> directory,
		owner	=> '0',
		group	=> 'lp',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/cups"
	}

	file { '/etc/cups/cupsd.conf':
		ensure	=> file,
		mode	=> '0640',
		notify  => Service[$cups_server_service],
		source	=> "puppet:///$environment/217-base/etc/cups/cupsd.conf"
	}

	$cups_secrets = ['/etc/cups/classes.conf', '/etc/cups/printers.conf']
	$cups_secrets.each |$file| {

		exec { "removing default `${file}`":
			path	=> "/usr/bin:/usr/sbin:/bin",
			command => "/bin/rm ${file} -f",
			onlyif	=> [
				"sh -c '! grep R217 ${file}'"
			],
		}

		file { $file:
			ensure	=> file,
			replace	=> 'no',
			notify  => Service[$cups_server_service],
			mode	=> '0600',
			source	=> "puppet:///$environment/217-base${file}"
		}
	}

    ##################
    ### Cups Proxy ###
    ##################

	group { 'wscups':
		ensure	=> 'present',
		system	=> 'yes',
		gid	=> '9999',
	} ->

	user { 'wscups':
		ensure	=> 'present',
		system	=> 'yes',
        gid => 'wscups',
		uid	=> '9999',
	} ->

    # Proxy script
	file { '/usr/bin/cups-proxy':
		ensure	=> file,
		owner	=> 'wscups',
		group	=> 'wscups',
		mode	=> '0554',
		source	=> "puppet:///$environment/217-base/usr/bin/cups-proxy"
	} ->

    # Proxy Systemd service file
    file { '/etc/systemd/system/cups-proxy.service':
        owner	=> 0,
        group	=> 0,
        mode	=> '0644',
        source  => "puppet:///$environment/217-base/etc/systemd/system/cups-proxy.service"
	} ->

    # CUPS Proxy
    file { "$cups_runtime_dir":
        ensure	=> directory,
		owner	=> '0',
		group	=> '0',
	} ->

    file { "$cups_runtime_dir/cups.sock":
        ensure	=> link,
        target	=> "$cups_runtime_dir/proxy/proxy.sock"
	} ->

    # Cups proxy socket directory
	file { "$cups_runtime_dir/proxy":
		ensure	=> directory,
		owner	=> '0',
		group	=> 'wscups',
		mode	=> '0775'
	} ->

	service { $cups_proxy_service:
		ensure	=> 'running'
	}

    # Actual Cups server socket directory
	file { "$cups_runtime_dir/server":
		ensure	=> directory,
		owner	=> '0',
		group	=> 'wscups',
		mode	=> '0550'
	} ~>

	service { $cups_server_service:
		ensure	=> 'running',
		notify  => Service[$cups_proxy_service]
	}

}
