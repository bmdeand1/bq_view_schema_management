## Managing schema changes in BigQuery Views

Demo to show an infrastracture as code example to propagate BigQuery table schema changes to `SELECT *` views.

The main.tf view block includes a [replace_triggered_by](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#replace_triggered_by) lifecycle rule to recreate the view upon table changes applying the original schema to add new columns and propagate descriptions.

This demo can be run as follows:

1. Run `terraform init`

2. Run `terraform apply`

3. Uncomment `column_two` in [schema file](schemas/example_table_one.json)

4. Run `terraform apply` again
