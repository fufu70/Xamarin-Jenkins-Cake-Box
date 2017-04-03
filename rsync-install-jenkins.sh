#!/bin/bash
# Currently the Vagrantfile uses rsync to push up the files
# to the server. To fullfill the rsync manually this bash script
# exists.


rsync -aHvz ./install-jenkins vagrant@192.168.205.30:/Users/vagrant