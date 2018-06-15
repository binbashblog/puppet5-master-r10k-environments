# puppet5-master-r10k-environments
Puppet 5 master managed with r10k, using roles/profiles structure and hiera

To use, install puppetserver 5 from the official PuppetLabs repository for your OS.

Install r10k via Ruby Gem which should be included with your Linux OS:
```sudo gem install r10k```

Then install bundler via Ruby Gem which should be included with your Linux OS:
```sudo gem install bundler```

git clone the puppet5-master-r10k repository to your home directory.

cd into the puppet5-master-10k repository, modify the r10k.yaml file if you want to use your own repo, otherwise my repo will be deployed instead.

While still in the puppet5-master-10k repo, run this:

```bundle install --binstubs --path vendor```

Then run: 
```bin/r10k deploy environment -p -v```

Then you should see your (or my) Puppet repo and all the modules inside the Gemfile in the puppet5-master-10k-environments repo being pulled down into the correct location on your puppet master/server.
R10k takes care of everything. If you go to the environments directory on the server you will see R10k has installed all the 3rd party modules and also pulled down all the manifests.

