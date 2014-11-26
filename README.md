Space Station
=============
This is an Ansible playbook for setting up cloud servers running CentOS.
It's called "Space Station" because I name all of mine after space stations.
(The first one is Skylab.)


How to Use
----------
1.  Probably fork this repository, 'cause most of this is tuned for my
    preferences. Yours will probably differ.

2.  Copy `example-playbook.yml` to something else (like `space-station.yml`)
    and edit it with your user information and whatnot.

3.  Edit the dotfiles in `roles/user/files` too.

4.  Create an `inventory.txt` file with the hostnames of any machines
    mentioned in your playbook. (It would be nice if Ansible just let you
    put hostnames in the playbook, but whatever.)

5.  Run `ansible-playbook -i inventory.txt space-station.yml`.
    It'll set everything up nicely.


Roles
=====
* `firewalld` turns on firewalld, and provides a `Restart firewalld` handler
  for everyone else to use.

* `server-tools` installs some packages I like. (All of these are in Fedora,
  but I had to add a couple of OpenSUSE Build Service repositories to get
  them on CentOS.)

* `server-secure` installs and configures logwatch and fail2ban.
  The default configuration is really nice, so they work pretty much out
  of the box.

* `tarsnap` builds and installs Tarsnap and Tarsnapper, for backups.
  It doesn't create a key, since that requires your account password:
  after running the playbook, log in and run (as root)
  `tarsnap-keygen --keyfile /root/tarsnap.key`.

* `tarsnap-nightly` provides some additional systemd support for running
  nightly backups. Any service wanted by `nightly-backups.target` gets run at
  3:45 AM. And, if you create a Tarsnapper configuration file named
  `/etc/tarsnapper.d/foo.yml` and enable the `tarsnapper@foo.service` unit,
  it automatically gets pulled in to the `nightly-backups` target.
  (This hasn't been fully tested yet, because I don't have roles that
  generate data worth backing up!)

* `user` creates my configuration files. (Note that installing the SSH key
  currently assumes that there's an account on the machine you're running
  Ansible from that contains that SSH key. You may have to tweak this a bit.)

* `quasselcore` sets up a Quassel core, with its own account and a self-signed
  SSL certificate.

