

class ws::cups {


	$packages = $::operatingsystem ? {
		"Archlinux"	=> ['cups', 'ghostscript', 'gsfonts'],
		"FreeBSD"	=> ['cups']
	}

	package { $packages:
		ensure	=> 'present'
	}


	$cups_service = "org.cups.cupsd.service"

	file { '/etc/cups':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> '0',
		group	=> 'lp',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/cups'
	}
	file { '/etc/cups/ppd':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> '0',
		group	=> 'lp',
		mode	=> '0640',
		source	=> 'puppet:///wslab/217-base/etc/cups/ppd'
	}

	$cups_secrets = ['/etc/cups/classes.conf', '/etc/cups/printers.conf']
	$cups_secrets.each |$file| {
		file { $file:
			ensure	=> file,
			notify  => Service[$cups_service],
			mode	=> '0600',
		}
	}

	service { $cups_service:
		ensure	=> 'running'
	}
}
