
class ws::files {

	$root_scripts = [
		'nicer.sh',
		'sethome.sh',
		'pacman-full-upgrade.sh',
		'nfs-check.sh',
		'nfs-temp-create.py'
	]

	$root_scripts.each |$script| {
		file { "/root/${script}":
			ensure	=> file,
			mode	=> '0744',
			source	=> "puppet:///$environment/217-base/root/${script}"
		}
	}

	## /usr
	file { '/usr/lib':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> '0',
		group	=> '0',
		source	=> "puppet:///$environment/217-base/usr/lib"
	}

	file { '/usr/share':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> '0',
		group	=> '0',
		source	=> "puppet:///$environment/217-base/usr/share"
	}

    # Diverted binaries: replace the pre-installed binaries
	$diverts = ['/usr/bin/lp', '/usr/bin/lpr', '/usr/bin/chsh', '/usr/bin/passwd']

	# prevent putting '/usr/bin/lp*' before Pacman installs cups
	require ws::cups

	$diverts.each |$file| {
		$orig = "${file}.orig"
		exec { "keep ${file}":
			path	=> "/usr/bin:/usr/sbin:/bin",
			command => "/bin/cp ${file} ${orig} -a",
			onlyif	=> [
				"sh -c '! test -f ${orig}'",
				"sh -c 'test -f ${file}'"
			],
		} ->
        file { "${file}":
			ensure	=> file,
			source	=> "puppet:///$environment/217-base${file}"
        }
	}

	## SSL
	file { '/etc/ssl':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/ssl"
	}

	## alias for lp*
	$profiles = [
		'/etc/bash.bashrc',
		'/etc/profile.d/tcsh-aliases',
		'/etc/profile'
	]

	$profiles.each |$file| {
		file { "${file}":
			ensure	=> file,
			owner	=> '0',
			group	=> '0',
			mode	=> '0644',
			source	=> "puppet:///$environment/217-base${file}"
		}
	}

	## motd
	file { '/etc/motd':
		ensure	=> file,
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/motd"
	}

	file { '/etc/security/limits.d/':
		ensure	=> directory
	} ->

	## limits.d/wslab.conf
	file { '/etc/security/limits.d/wslab.conf':
		ensure	=> file,
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/security/limits.d/wslab.conf",
		replace	=> false
	}
	exec { 'substitute vmem_max in wslab.conf':
		path	=> '/usr/bin:/usr/sbin:/bin',
		command	=> 'sh /usr/share/217-base/limits.wslab.sh',
		onlyif	=> 'sh -c "grep -q vmem_max /etc/security/limits.d/wslab.conf"',
	}

	## sysctl.d/10-ptrace.conf
	file { '/etc/sysctl.d/10-ptrace.conf':
		ensure	=> file,
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/sysctl.d/10-ptrace.conf",
		replace	=> false
	}

	## default/grub
	file { '/etc/default/grub':
		ensure	=> file,
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> "puppet:///$environment/217-base/etc/default/grub",
		replace	=> true
	}
	
	## write/wall/talk permission

	file { '/usr/bin/write':
		ensure => file,
		mode => '0754'
	}

	file { '/usr/bin/wall':
		ensure => file,
		mode => '2754'
	}

	file { '/usr/bin/talk':
		ensure => file,
		mode => '2754'
	}
}
