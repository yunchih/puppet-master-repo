class ws::nfs {
	
	$nfs_package = $::operatingsystem ? {
		/(Archlinux)/		=> 'nfs-utils',
		default			=> 'nfs-common'
	}
	$nfs_service = $::operatingsystem ? {
		"Archlinux"	=> ['rpcbind.service','nfs-client.target','remote-fs.target'],
		"FreeBSD"	=> ['nfsclient']
	}
	package { $nfs_package:
		ensure	=> 'present'
	}

	file { '/etc/auto.master.d':
		ensure	=> directory,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '644',
	}

	$autos = [ 
		'/etc/auto.master.d/backup.autofs', 
		'/etc/auto.master.d/ntucsp.autofs', 
		'/etc/auto.master',
		'/etc/auto.nfs',
		'/etc/auto.backup'
	]

	$autos.each |$auto| { 
		file { $auto:
			ensure	=> file,
			owner	=> 'root',
			group	=> 'root',
			mode	=> '644',
			source	=> "puppet:///wslab/217-base${cron}"
		}
	}

	service { $nfs_service:
		ensure	=> 'running'
	}


}


