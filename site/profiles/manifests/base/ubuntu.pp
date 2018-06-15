# profiles/manifests/base/ubuntu.pp
class profiles::base::ubuntu {

# common repositories for ubuntu 
    #create_resources('aptrepo', hiera_hash('aptrepo', {}))

# common modules and profiles
    include ntp
    include motd
    include profiles::ssh::server
    include profiles::firewall::setup

    # common groups
    group { "staff":
        ensure => present,
        gid => 500,
    }
    group { "sysadmins":
        ensure => present,
        gid => 501,
    }
    # common users
    users { 'default': }

    # delete ufw so that firewall module will work with iptables
    package {[
               'ufw'
           ]:
           ensure => absent,
       }
    # Purge firewallchains created by UFW to control iptables
    firewallchain { 'INPUT:filter:IPv4':
            ensure => present,
            policy => accept,
            before => undef,
    }
    firewallchain { 'FORWARD:filter:IPv4':
            ensure => present,
            policy => accept,
            before => undef,
    }
    firewallchain { 'OUTPUT:filter:IPv4':
            ensure => present,
            policy => accept,
            before => undef,
    }
    firewallchain { 'INPUT:filter:IPv6':
            ensure => present,
            policy => accept,
            before => undef,
    }
    firewallchain { 'FORWARD:filter:IPv6':
            ensure => present,
            policy => accept,
            before => undef,
    }
    firewallchain { 'OUTPUT:filter:IPv6':
            ensure => present,
            policy => accept,
            before => undef,
    }
    resources { 'firewallchain':
      purge => true,
    }


    # creates a file in profile.d that adds the new puppet bin location to the path variable in bash, so you don't have to type the full path to the puppet binary
    file { '/etc/profile.d/puppet-agent.sh':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        content => file( 'profiles/base/puppet-agent.sh'),
    }

    # creates a file in profile.d that adds aliases for puppet, so you don't have to type the full text
    $puppetrun = "alias prun='puppet agent -t'"
    $puppettest = "alias ptest='puppet agent -t --noop'"
    file { '/etc/profile.d/puppet_alias.sh':
        content => "${puppetrun}\n${puppettest}\n",
        mode    => '644',
        ensure  => present,
    }

    # common packages needed everywhere
    package {[
            'vim',
            'sudo',
            'screen',
            'traceroute',
            'ntpdate',
            'man',
        ]:
        ensure => present,
    }

    # set common locale
    class { 'locales':
        default_locale => 'en_GB.UTF-8',
        locales        => ['en_GB.UTF-8 UTF-8'],
    }

    # making sure the puppet agent is started and enabled after the first time running
    service { 'puppet':
        ensure => 'running',
        enable => 'true',
    }

}

