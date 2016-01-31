

class ws::ldap {
	
	
	$ldap_package = $::operatingsystem ? {
		"Archlinux"	=> ['openldap', 'nss-pam-ldapd'],
		"FreeBSD"	=> ['openldap-client','nss-pam-ldapd']
	}

	package { $ldap_package:
		ensure	=> 'present'
	}

	file { '/etc/openldap':
		ensure	=> directory,
		recurse	=> remote,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/ldap'
	}
	
	$ldap_files = ['/etc/pam_ldap.conf', '/etc/nsswitch.conf', '/etc/nslcd.conf']
	$ldap_files.each |$file| { 
		file { $file:
			ensure	=> file,
			owner	=> 'root',
			group	=> 'root',
			mode	=> '644',
			source	=> "puppet:///wslab/217-base${file}"
		}
	}

}

#	# datacentred-ldap template	
#	class { 'openldap::client':
#		base		=> 'dc=csie,dc=ntu,dc=edu,dc=tw',
#		uri		=> 'ldap://ms.csie.ntu.edu.tw ldap://ntucsv.csie.ntu.edu.tw',
#		ssl		=> true,
#		ssl_cert	=> '/etc/ssl/certs/ntucsie-ca.pem',
#		ssl_reqcert	=> 'never',
