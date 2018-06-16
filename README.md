# puppet5-master-r10k
Puppet 5 master managed with r10k, using roles/profiles structure and hiera

To use, first install puppetserver 5 from the official PuppetLabs repository for your OS.
Then git clone the 3 repositories into seperate folders in your home directory.
Then cd into the puppet5-master-r10k directory you cloned from my Git repository (not the configdir or environment one).

Install r10k via Ruby Gem which should be included with your Linux OS, first the prerequisites:
```sudo gem install bundler```   
```bundle install --binstubs --path vendor```   

The Gemfile inside the directory should contain this contents which should be found and installed r10k by the above bundle install line:

```
source "https://rubygems.org"
gem 'r10k'

```

Modify the r10k.yaml file if you want to use your own repo, otherwise my repo will be deployed instead.


Then run: 
```bin/r10k deploy environment -p -v```

Then you should see your (or my) Puppet repo and all the modules inside the Gemfile in the puppet5-master-10k-environments repo being pulled down into the correct location on your puppet master/server.
R10k takes care of everything. If you go to the environments directory on the server you will see R10k has installed all the 3rd party modules and also pulled down all the manifests.

Now, all you need to do is cd into the puppet5-master-r10k-environments directory and make your changes there, after that you will need to reconfiger it to your own git repo, then push the changes. Ensure you use branch names according to the environments you want to set up e.g. production, development, testing, etc, whatever is appropriate for your environment so that when you run the r10k deploy, it deploys all the branches as seperate environments.

You can develop this further, either by setting up a webhook so every time you push to your git repo, r10k will deploy the changes, however this could be insecure. Another way could be to run a daily cron job to run the command.
