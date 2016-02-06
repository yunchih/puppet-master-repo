class ws::pkg {

	$pkgs = hiera("wspkg::pkgs")
	$pkgs_map = hiera_hash("wspkg::map") # Find all mappings in common.yaml and $::osfamily.yaml
	$pkgs_mapped = $pkgs.map |$pkg| { $pkgs_map["$pkg"] }
	$pkgs_resolved = $pkgs_mapped.filter |$pkg| {  ("$pkg" != undef) and ("$pkg" != "") and (! defined(Package["$pkg"]))  }

	# split packages within same group and trim duplicate packages
	$pkgs_all = unique( flatten( $pkgs_resolved.map |$pkg| { split($pkg, ' ') } ) ).filter |$pkg| { "$pkg" != "" }

	$agent = $trusted['certname']
	notice( "Packages installed to node `${osfamily}::${agent}`:" )
	$pkgs_all.each |$pkg| { notice( $pkg ) }
	
	$unwanted_pkgs = hiera("wspkg::purgelist")
	#$unwanted_pkgs.each |$pkg| { 
	#	notice( "Purging $pkg" ) 
	#	package { $pkg:
	#		ensure	=> 'absent'
	#	}
	#}

	ensure_packages( $pkgs_all )

	#ensure_resource('package', $pkgs_all, { 'ensure' => 'present' })
}
