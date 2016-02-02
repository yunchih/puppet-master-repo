

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
		recurse	=> true,
		purge	=> false,
		owner		=> '0',
		group		=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/cups'
	}
	
	$cups_secrets = ['/etc/cups/classes.conf', '/etc/cups/cupsd.conf', '/etc/cups/printers.conf']
	$cups_secrets.each |$file| { 
		file { $file:
			ensure	=> file,
            notify  => Service[$cups_service],
			mode	=> '600',
		}
	}

	service { $cups_service:
		ensure	=> 'running'
	}
}
