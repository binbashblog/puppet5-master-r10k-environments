# Config for Puppet master nodes
class profiles::puppetmaster {

  firewall { '100 allow puppetserver listening port':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '8140',
    proto  => 'tcp',
    action => 'accept',
  }

