# profiles/manifests/base/windows.pp
class profiles::base::windows {
    # common repositories for windows
    # chocolatey
    create_resources('chocrepo', hiera_hash('chocrepo', {}))



}

