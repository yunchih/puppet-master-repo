

class ws::cups {


	$packages = $::operatingsystem ? {
		"Archlinux"	=> ['cups', 'ghostscript', 'gsfonts', 'hplip'],
		"FreeBSD"	=> ['cups']
	}

	package { $packages:
		ensure	=> 'present'
	}


	$cups_service = "org.cups.cupsd.service"

	file { '/etc/cups':
		ensure	=> directory,
		owner	=> '0',
		group	=> 'lp',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/cups'
	}

	file { '/etc/cups/cupsd.conf':
		ensure	=> file,
		mode	=> '0640',
		source	=> 'puppet:///wslab/217-base/etc/cups/cupsd.conf'
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
			notify  => Service[$cups_service],
			mode	=> '0600',
			source	=> "puppet:///wslab/217-base${file}"
		}
	}

	service { $cups_service:
		ensure	=> 'running'
	}
}
