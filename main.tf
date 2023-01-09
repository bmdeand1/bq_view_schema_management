provider "google" {
  project = var.gcp_project_id
  region  = var.region
}

resource "google_bigquery_dataset" "example_dataset" {
  dataset_id = "example_dataset"
  location   = "EU"
}

resource "google_bigquery_table" "example_table" {
  dataset_id          = google_bigquery_dataset.example_dataset.dataset_id
  table_id            = "example_table"
  schema              = file("./schemas/example_table_one.json")
  deletion_protection = false
}

resource "google_bigquery_table" "example_view" {
  dataset_id          = google_bigquery_dataset.example_dataset.dataset_id
  table_id            = "example_view"
  schema              = replace(file("./schemas/example_table_one.json"), "REQUIRED", "NULLABLE")
  deletion_protection = false

  view {
    query          = "SELECT * FROM ${var.gcp_project_id}.example_dataset.example_table"
    use_legacy_sql = false
  }

  depends_on = [
    google_bigquery_table.example_table
  ]

  lifecycle {
    replace_triggered_by = [
      google_bigquery_table.example_table
    ]
  }
}



 