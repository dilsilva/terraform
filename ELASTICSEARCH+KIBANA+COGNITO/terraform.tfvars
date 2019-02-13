# Infos

AWS_ACCOUNT                 = "158207973304"
AWS_REGION                  = "us-east-1"
AKEY                        = "AKIAJUSGE5EJ6UY25EJQ"
SKEY                        = "vT/e+OTvIzkC0XGYgTfpUx1V/paSIMmOICue0gP2"


#EBS
ebs_volume_size             = "10"
ebs_volume_type             = "gp2"
ebs_iops                    = 0

#ES
elasticsearch_version       = "6.4"
stage                       = "test"
name                        = "minihub"
tags                        = {
                                "name" = "minihub"
                                "env"  = "test"
                                }

##ENCRYPTION
encrypt_at_rest_enabled     = "false"
# encrypt_at_rest_kms_key_id  = "false"
node_to_node_encryption_enabled = "false"
##CLUSTER
instance_count              = 1         
instance_type               = "t2.small.elasticsearch"            

dedicated_master_type       = "0"    
dedicated_master_enabled    = ""   
dedicated_master_type       = "0"
dedicated_master_count      = ""
zone_awareness_enabled      = "false"

#OPTIONS
automated_snapshot_start_hour = 23

kibana_authentication_enabled = "true"