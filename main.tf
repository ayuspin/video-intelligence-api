provider "google" {
  project = "python-258010"
  region  = "europe-west4"
  #region  = "us-central1"
  zone    = "europe-west4-a"
  #zone    = "us-central1-a"
}


resource "google_storage_bucket" "video-intelligence-api-bucket" {
  location           = "EUROPE-WEST4"
  name               = "video-intelligence-api-bucket"
}


resource "google_cloudfunctions_function" "video-intelligence-api-function" {
  available_memory_mb   = 128
  trigger_http          = false
  entry_point           = "main"
  max_instances         = 0
  name                  = "video-intelligence-api-function"
  region                = "europe-west4"
  runtime               = "python37"
  service_account_email = "python-258010@appspot.gserviceaccount.com"
  timeout               = 60

  event_trigger {
     event_type = "google.storage.object.finalize"
     resource   = "projects/_/buckets/video-intelligence-api-bucket"

     failure_policy {
         retry = false
     }
  }

}
