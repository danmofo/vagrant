Vagrant development configuration
====

Vagrant
---
Uses the `hashicorp/precise64` box and installs the following software:

- Apache HTTP Server
- Apache Tomcat
- ?? MySQL
- ?? Elasticsearch

Using (only have to do this once)
---

1. Clone repo.
2. Create an `applications` folder, `private` folder and `server` folder.
3. `vagrant up`
4. Add `hosts` to `/etc/hosts` on the local machine, make sure they work. If no response check the guest IP is correct (todo, make the IP address static)
5. Follow steps in `docs/linking-sources.md` to link project sources to Tomcat.


Developing
---

1. Work directly inside workspace directory (using Eclipse).
2. When you want to see your changes, `m` to restart Tomcat, if you've changed Apache configuration, `mm`.

todo: depending on how quick the save/reload cycle is, I may continue running Tomcat directly through Eclipse and only copy when finished



