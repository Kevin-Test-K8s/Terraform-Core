resource_group_name = "${yamldecode(file("variables.yml")).resource_group_name}"
cluster_name = "${yamldecode(file("variables.yml")).cluster_name}"
location = "${yamldecode(file("variables.yml")).location}"
subscription_id = "${yamldecode(file("variables.yml")).subscription_id}"
