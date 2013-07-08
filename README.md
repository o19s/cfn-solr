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
   the zookeeper server over port 8983, and optionally the public access over port 8983

Port (Service)	Source	Action
22		0.0.0.0/0	Delete
2181	sg-58d77733	Delete
8080 (HTTP*)	0.0.0.0/0	Delete
8983	0.0.0.0/0	Delete


example of bootstrapping zookeeper:
cloud-scripts/zkcli.sh -cmd upconfig -zkhost ec2-23-22-185-215.compute-1.amazonaws.com:2181/cluster2 -collection slrCloud -confname conf1 --confdir solr/collection1/conf/


example of running cfn-create-stack script:
cfn-create-stack slrCld --template-file solr_cfn_template.json --parameters "KeyName=vagrant;InstanceType=m1.small;SecurityGroup=solr_cloud;ZookeeperHost=ec2-72-44-55-216.compute-1.amazonaws.com:2181/cld2;SolrCloudSize=4"

cfn-create-sta --aws-credential-file credential-file-path --capabilities CAPABILITY_IAM --disable-rollback -template-file find_zips_that_need_parsing_template.json --parameters "QueueName=index-patents-2010;SolrUrl=http://solr.data-final3.lws.o19s.com/solr/cn_patent"