cfn-solr
========

Cloud formation script for solr servers.

A cluster of n number of ec2-instances will be created running RHEL 6.4
and solr in it's own tomcat instance.

requirements
--------

You'll need

1. A running zookeeper with a loaded solr configuration
2. The Oracle JDK linux rpm downloaded, tar'ed or zipped and made
   available via http to the servers.
3. An AWS security group that allows instances to communication with
   the zookeeper server over port 8983, and optionally the public access
over port 8983

