cfn-solr
========

Cloud formation script for solr servers.

A cluster of n number of ec2-instances will be created running RHEL 6.4
and solr in it's own tomcat instance.

requirements
--------

You'll need

1. A running zookeeper with a loaded solr configuration (see below)
2. The Oracle JDK linux rpm downloaded, tar'ed or zipped and made
   available via http to the servers.
3. An AWS security group that allows instances to communication with
   the zookeeper server over port 8983, and optionally the public access over port 8983

Example AWS security group:

Port (Service)	Source	Action
22		0.0.0.0/0	Delete
2181	sg-58d77733	Delete
8080 (HTTP*)	0.0.0.0/0	Delete
8983	0.0.0.0/0	Delete



Installing Zookeeper
--------------

Add the Cloudera Zookeeper Yum Repo
cd /etc/yum.repo.d/
sudo wget http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/cloudera-cdh4.repo
sudo yum install zookeeper-server
sudo service zookeeper-server init
sudo service zookeeper-server start


Installing SolrCloud
----------------

Use solr_cfn_template.json
	SecurityGroup: solr_cloud
	SolrCloudSize
	ZookeeperHost: ec2-54-242-84-36.compute-1.amazonaws.com:2181
	InstanceType: m1.xlarge
	KeyName: lws-key

Add tags
	Name: eric





example of bootstrapping zookeeper:
```bash
cloud-scripts/zkcli.sh -cmd upconfig -zkhost ec2-23-22-185-215.compute-1.amazonaws.com:2181/cluster2 -collection slrCloud -confname conf1 --confdir solr/collection1/conf/
```

Check if via 
```
zookeeper-client -server ec2-54-242-84-36.compute-1.amazonaws.com:2181
```

example of running cfn-create-stack script:
```bash
cfn-create-stack slrCld --template-file solr_cfn_template.json --parameters "KeyName=vagrant;InstanceType=m1.small;SecurityGroup=solr_cloud;ZookeeperHost=ec2-72-44-55-216.compute-1.amazonaws.com:2181/cld2;SolrCloudSize=4"
```

example of running cfn-create-vpc-stack script:
```bash
cfn-create-stack slrCld-(date +%s) --template-file solr_cfn_vpc_template.json --parameters "KeyName=vagrant;InstanceType=m1.small;SecurityGroup=solr_cloud;ZookeeperHost=ec2-72-44-55-216.compute-1.amazonaws.com:2181/cld2;SolrCloudSize=1;Subnets=subnet-0406006b;AZs=us-east-1a"
```


 curl "http://ec2-54-221-85-31.compute-1.amazonaws.com:8983/solr/admin/collections?action=SPLITSHARD&collection=data_audit_raid10&shard=shard1"


 curl "http://ec2-54-221-85-31.compute-1.amazonaws.com:8983/solr/data_audit_raid10_shard1_replica1/replication?command=fetchindex&masterUrl=http://ec2-23-20-79-92.compute-1.amazonaws.com/solr/data_audit"

 curl "http://ec2-54-221-85-31.compute-1.amazonaws.com:8983/solr/admin/collections?action=CREATE&name=data_audit_raid10&collection.configName=data_audit&numShards=2&replicationFactor=2"


 ./zkcli.sh -cmd upconfig -zkhost ec2-50-19-136-115.compute-1.amazonaws.com:2181/gpsn -confdir ~/Documents/solr/collections/data_audit/conf/ -confname data_audit
