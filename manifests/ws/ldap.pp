

class ws::ldap {
	
	
	$ldap_package = $::operatingsystem ? {
		"Archlinux"	=> ['python2-ldap', 'libpwquality', 'python2-smbpasswd'],
		"FreeBSD"	=> ['openldap-client','nss-pam-ldapd']
	}

	package { $ldap_package:
		ensure	=> 'present'
	}

	$ldap_files = ['/etc/pam_ldap.conf', '/etc/nsswitch.conf', '/etc/pam.d/system-auth', '/etc/pam.d/su', '/etc/pam.d/su-l', '/etc/pam.d/passwd', '/etc/pam.d/sudo']
	$ldap_files.each |$file| { 
		file { $file:
			ensure	=> file,
			owner	=> '0',
			group	=> '0',
			mode	=> '644',
			source	=> "puppet:///$environment/217-base${file}"
		}
	}
}
