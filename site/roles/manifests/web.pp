#role/manifests/web.pp
class role::web {
  include profiles::base
  include profiles::lamp
}

