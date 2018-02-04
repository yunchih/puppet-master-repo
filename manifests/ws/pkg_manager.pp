
class ws::pkg_manager {
    if $operatingsystem == 'Archlinux' {

        file { '/etc/pacman.conf':
            ensure  => file,
            owner   => '0',
            group   => '0',
            source  => "puppet:///$environment/217-base/etc/pacman.conf"
        }

        file { '/etc/pacman.d/mirrorlist':
            ensure  => file,
            source  => "puppet:///$environment/217-base/etc/pacman.d/mirrorlist"
        }
    }
}

