
# Getting started with puppet Modules:
  - a module in puppet is a collection of puppet code that helps us configure an end state. i Example create a module thta installs, configures and start MySQL service.

- Login to puppet server:
1. ssh cloud_user@PUBLIC_IP_ADDRESS
- Create an Installation Class:
1. Generate the mysql module:
    - cd /etc/puppetlabs/code/environments/production/modules
    - sudo pdk new module mysql

    - Puppet Forge username: clouduser
    - Who wrote this module?: Enter your name at the prompt
    - What license does this module code fall under?: Apache-2.0
    - What operating systems does this module support?: RedHat based Linux, Debian based Linux
    - Metadata will be generated based on this information: Yes


 # HIERA -
- Puppet datastore, which let's you store key value pairs in a heirarchy of directories
- Set in two different ways:
    - modules specific key value pairs, example go into the module and set if ngix is enabled or not. override this further with node or role specific hiera data. 
- To setup module specific Hiera data which will contain our Hiera datangs like whether nginx is installed or not,  service enabled, allow for restarts

Provide Node specific key value pairs
