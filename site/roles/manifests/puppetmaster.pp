# puppetmaster server role
class roles::puppetmaster {
    include profiles::base
    include profiles::puppetmaster
}

