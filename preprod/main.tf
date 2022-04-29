module "sns" {
    source = "../modules/sns"
    topic_name = var.topic_name
}