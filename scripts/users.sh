#!/bin/bash -x

if [ $PACKER_BUILDER_TYPE = "amazon-ebs" ];
then
	# create chas and frank accounts
	useradd -G admin chas
	mkdir /home/chas
	mkdir /home/chas/.ssh

	echo %chas ALL=NOPASSWD:ALL > /etc/sudoers.d/chas
	chmod 0440 /etc/sudoers.d/chas

	# append $chas_ssh_key and $frank_ssh_key to each user's ~/.ssh/authorized_keys
	cp /tmp/chas_authorized_keys /home/chas/.ssh/authorized_keys
	chmod 0700 /home/chas/.ssh
	chmod 0600 /home/chas/.ssh/authorized_keys
	chown -R chas /home/chas/.ssh
fi
