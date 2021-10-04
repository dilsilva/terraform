#CONNECTION SETTINGS
AWS_ACCOUNT                 = ""
AWS_REGION                  = "us-east-1"
AKEY                        = ""
SKEY                        = ""

#ELASTICSEARCH DEFINITIONS
elasticsearch_version       = "6.4"
stage                       = "test"
name                        = "minihub"
tags                        = {
                                "name" = "minihub"
                                "env"  = "test"
                                }
##CLUSTER DEFINITIONS
instance_count              = 1         
instance_type               = "t2.small.elasticsearch"            
dedicated_master_type       = "0"    
dedicated_master_enabled    = ""   
dedicated_master_type       = "0"
dedicated_master_count      = ""
zone_awareness_enabled      = "false"
automated_snapshot_start_hour = 23
##EBS DEFINITIONS
ebs_volume_size             = "10"
ebs_volume_type             = "gp2"
ebs_iops                    = 0
##ENCRYPTION DEFINITIONS
encrypt_at_rest_enabled     = "false"
# encrypt_at_rest_kms_key_id  = "false"
node_to_node_encryption_enabled = "false"
#KIBANA DEFINITIONS
kibana_authentication_enabled = "true"
