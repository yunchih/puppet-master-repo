
class ws::wsmon {

	$wsmon_directories = [
		'/root/wsmon',
		'/root/wsmon/tmp2mon',
		'/run/wslab/',
		'/run/wslab/snmp'
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
			mode	=> '0550',
			owner	=> '0',
			group	=> 'robot',
			source	=> "puppet:///$environment/217-base/root/wsmon/${script}"
		}
	}

	file { '/root/wsmon/nagios-check.conf':
		ensure	=> file,
		mode	=> '0440',
		source	=> "puppet:///$environment/217-base/root/wsmon/nagios-check.conf"
	}

	file { '/root/wsmon/.ssh':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> 'wsmon',
		mode	=> '0700',
		source	=> "puppet:///$environment/217-base/root/wsmon/.ssh"
	}

}
