~/puppet-master-r10k/puppet/site/profiles/manifests/base.pp
# Config common to all nodes
class profiles::base {
    # os specific profiles
    case $::operatingsystem {
      'debian': {
        include profiles::base::debian
      }
      'redhat': {
        include profiles::base::redhat
      }
      'centos': {
        include profiles::base::centos
      }
      'ubuntu': {
        include profiles::base::ubuntu
      }
      'windows': {
        include profiles::base::windows
      }
      default: {
        fail("This profile is not compatible with your platform")
      }
    }


}

