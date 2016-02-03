

class ws::ldap {
	
	
	$ldap_package = $::operatingsystem ? {
		"Archlinux"	=> ['openldap', 'nss-pam-ldapd','python2-ldap', 'libpwquality', 'python2-smbpasswd'],
		"FreeBSD"	=> ['openldap-client','nss-pam-ldapd']
	}
	$ldap_service = $::operatingsystem ? {
		default	=> ['nslcd'],
	}

	package { $ldap_package:
		ensure	=> 'present'
	}

	file { '/etc/openldap':
		ensure	=> directory,
		recurse	=> remote,
		owner		=> '0',
		group		=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/ldap'
	}
	
	$ldap_files = ['/etc/pam_ldap.conf', '/etc/nsswitch.conf', '/etc/nslcd.conf']
	$ldap_files.each |$file| { 
		file { $file:
			ensure	=> file,
            notify  => Service[$ldap_service],
			owner		=> '0',
			group		=> '0',
			mode	=> '644',
			source	=> "puppet:///wslab/217-base${file}"
		}
	}

	service { $ldap_service:
		ensure	=> 'running'
	}

}

#	# datacentred-ldap template	
#	class { 'openldap::client':
#		base		=> 'dc=csie,dc=ntu,dc=edu,dc=tw',
#		uri		=> 'ldap://ms.csie.ntu.edu.tw ldap://ntucsv.csie.ntu.edu.tw',
#		ssl		=> true,
#		ssl_cert	=> '/etc/ssl/certs/ntucsie-ca.pem',
#		ssl_reqcert	=> 'never',
