
class ws::files {

	# prevent putting '/usr/bin/lp*' before Pacman installs cups
	require ws::cups  

	$diverts = ['/usr/bin/lp', '/usr/bin/lpr', '/usr/bin/chsh', '/usr/bin/passwd', '/usr/bin/lpstat']

	$diverts.each |$file| { 
		$orig = "${file}.orig"
		exec { "keep ${file}":
			path	=> "/usr/bin:/usr/sbin:/bin",
			command => "/bin/cp ${file} ${orig} -r",
			onlyif	=> [
				"sh -c '! test -f ${orig}'",
				"sh -c 'test -f ${file}'"
			],
		}
	}

	## /root 
	file { '/root':
		ensure	=> directory,
		recurse	=> remote,
		owner		=> '0',
		group		=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/root'
	}
	file { '/root/wsmon':
		ensure	=> directory,
		recurse	=> remote,
		mode	=> '0660',
		source	=> 'puppet:///wslab/217-base/root/wsmon'
	}

	## /usr 
	file { '/usr':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> '0',
		group	=> '0',
		source	=> 'puppet:///wslab/217-base/usr'
	}
	
	## SSL 
	file { '/etc/ssl':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/ssl'
	}

}
