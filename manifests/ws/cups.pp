

class ws::cups {
	
	
	$packages = $::operatingsystem ? {
		"Archlinux"	=> ['cups', 'ghostscript', 'gsfonts'],
		"FreeBSD"	=> ['cups']
	}

	package { $packages:
		ensure	=> 'present'
	}

	file { '/etc/cups':
		ensure	=> directory,
		recurse	=> true,
		purge	=> false,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/cups'
	}
	
	$cups_secrets = ['/etc/cups/classes.conf', '/etc/cups/cupsd.conf', '/etc/cups/printers.conf']
	$cups_secrets.each |$file| { 
		file { $file:
			ensure	=> file,
			mode	=> '600',
		}
	}

	service { "org.cups.cupsd.service":
		ensure	=> 'running'
	}
}
