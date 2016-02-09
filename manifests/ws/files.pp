
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
		owner	=> '0',
		group	=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/root'
	}

	$wsmon_directories = [
		'/root/wsmon',
		'/root/wsmon/tmp2mon'
	]

	$wsmon_directories.each |$dir| {
		file { "${dir}":
			ensure	=> directory,
			mode	=> '0750',
			owner	=> 'wsmon',
			group	=> 'robot'
		}
	}

	$wsmon_scripts = [
		'get-cpu-util',
		'get-matlab-license',
		'get-memory',
		'get-tmp2top',
		'get-uptime',
		'nagios-check',
		'root-update.sh',
		'tmp2mon/tmp2node.sh',
		'tmp2mon/tmp2node-nolock.sh',
		'update.sh'
	]

	$wsmon_scripts.each |$script| {
		file { "/root/wsmon/${script}":
			ensure	=> file,
			recurse	=> remote,
			mode	=> '0550',
			owner	=> '0',
			group	=> 'robot',
			source	=> "puppet:///wslab/217-base/root/wsmon/${script}"
		}
	}

	file { '/root/wsmon/nagios-check.conf':
		ensure	=> file,
		mode	=> '0440',
		source	=> 'puppet:///wslab/217-base/root/wsmon/nagios-check.conf'
	}

	file { '/root/wsmon/.ssh':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> 'wsmon',
		mode	=> '0700',
		source	=> 'puppet:///wslab/217-base/root/wsmon/.ssh'
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
			source	=> "puppet:///wslab/217-base${file}"
		}
	}

	### motd
	#file { '/etc/motd':
	#	ensure	=> file,
	#	owner	=> '0',
	#	group	=> '0',
	#	mode	=> '0644',
	#	source	=> 'puppet:///wslab/217-base/etc/motd'
	#}

	### /etc/$directories
	#file { ['/etc/limit.d']:
	#	ensure	=> directory,
	#	owner	=> '0',
	#	group	=> '0',
	#	mode	=> '0644',
	#}

	#file { ['/etc/motd', '/etc/limit.d/wslab.conf']:

}
