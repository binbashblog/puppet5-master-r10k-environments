# Config for mail server nodes
class profiles::mail {

  firewall { '100 allow mail listening port':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '25',
    proto  => 'tcp',
    action => 'accept',
  }
}

