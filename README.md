Vagrant development configuration
====

Vagrant
---
Uses the `hashicorp/precise64` box and installs the following software:

- Apache HTTP Server
- Apache Tomcat
- ?? MySQL
- ?? Elasticsearch

Using
---

1. Clone repo.
3. `vagrant up`
4. Add `hosts` to `/etc/hosts` on the local machine, make sure they work. If no response check the guest IP is correct (todo, make the IP address static)
5. Follow steps in `linking-sources.md` to link project sources to Tomcat.

-


