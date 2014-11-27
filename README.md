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
There are a LOT of roles, 'cause putting all of these on Galaxy is kind of
a hassle. I've grouped them here by category.

**WARNING:** Not all role dependencies have been properly established!
For now, it's probably safest to enumerate all roles!

Server Basics
-------------
These are just quick "install-and-configure software" packages.

* `firewalld` turns on firewalld, and provides a `Restart firewalld` handler
  for everyone else to use.

* `server-secure` installs and configures logwatch and fail2ban.
  The default configuration is really nice, so they work pretty much out
  of the box.


Backups
-------
These roles allow automated backups to be configured for the server.
They don't back anything up by default, so you have to add backup jobs
using other roles.

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


User Environment
----------------
These just install stuff.

* `server-tools` installs some packages (like command-line tools and
  programming language runtimes) that I like to have available.
  (All of these are in Fedora, but I had to add a couple of OpenSUSE
  Build Service repositories to get them on CentOS.)

* `user` creates my configuration files. (Note that installing the SSH key
  currently assumes that there's an account on the machine you're running
  Ansible from that contains that SSH key. You may have to tweak this a bit.)


LEP Web Server
--------------
LEP stands for Linux, (E)nginx, PHP. You can get a quick Web server that
just serves static pages on your machine's FQDN by enabling
`nginx`, `php-fpm-pool`, `nginx-simple-site` with no parameters,
but the roles are pretty customizable and let you plug in your own stuff.

* `nginx` installs Nginx itself and starts it up.
  It doesn't configure any servers -- those are placed in `/etc/nginx/conf.d`
  by other roles, like `nginx-simple-site`.

* `php-fpm` installs PHP and PHP-FPM, which manages PHP processes.
  (This is pulled in automatically by `php-fpm-pool`, so don't worry about
  activating this role manually.)

* `php-fpm-pool` creates an isolated PHP process pool instance, which you
  can use with Nginx. The defaults create a pool called `www` that can
  be used by the `nginx-simple-site` without extra configuration.

* `nginx-simple-site` adds Nginx configuration for a site that serves
  static files out of a particular directory. The defaults will use
  your machine's FQDN and the document root `/srv/www`.
  Provide `use_php: true` to enable PHP, using the default `php-fpm-pool`.


Miscellaneous Services
----------------------
* `quasselcore` sets up a Quassel core, with its own account and a self-signed
  SSL certificate.

