# Sets ssh config for all instances
class profiles::ssh::server {

    case $osfamily {
        'RedHat' : { $ssh_name = 'sshd' }
        'CentOS' : { $ssh_name = 'sshd' }
        'Debian' : { $ssh_name = 'ssh' }
        'Ubuntu' : { $ssh_name = 'ssh' }
        default : { fail('OS not supported by puppet module SSH') }
    }
    package { 'openssh-package':
        name   => 'openssh-server',
        ensure => present,
    }
    -> file { '/etc/ssh/sshd_config':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => file( 'profiles/ssh/sshd_config'),
        require => Package['openssh-package'],
        notify  => Service['ssh-service-alias'],
    }
    -> service { 'ssh-service':
        name       => $ssh_name,
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        alias      => 'ssh-service-alias',
        enable     => true,
    }
    firewall { '010 allow incoming ssh':
        chain    => 'INPUT',
        state    => ['NEW'],
        dport    => '22',
        proto    => 'tcp',
        action   => 'accept',
    }

}

