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
		ensure	=> 'latest'
	}

	file { '/etc/auto.master.d':
		ensure	=> directory,
		owner	=> '0',
		group	=> '0',
		mode	=> '644',
	}

	$autos = [ 
		'auto.master.d/backup.autofs', 
		'auto.master.d/ntucsp.autofs', 
		'auto.master',
		'auto.nfs',
		'auto.backup'
	]

	$autos.each |$auto| { 
		file { '/etc/autofs/$auto':
			ensure	=> file,
            notify  => Service[$nfs_service],
			owner	=> '0',
			group	=> '0',
			mode	=> '644',
			source	=> "puppet:///wslab/217-base/etc/${auto}"
		}
	}

	service { $nfs_service:
		ensure	=> 'running'
	}


}


