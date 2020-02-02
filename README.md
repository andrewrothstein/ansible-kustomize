andrewrothstein.kustomize
=========
[![Build Status](https://travis-ci.org/andrewrothstein/ansible-kustomize.svg?branch=master)](https://travis-ci.org/andrewrothstein/ansible-kustomize)

Installs [kustomize](https://github.com/kubernetes-sigs/kustomize)

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.kustomize
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
