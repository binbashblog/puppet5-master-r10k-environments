# ~/puppet5/puppet/manifests/site.pp
lookup('classes', Array[String], 'unique').include
