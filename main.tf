provider "google" {
  project = "python-258010"
  region  = "us-central1"
  zone    = "us-central1-a"
}


resource "google_storage_bucket" "video-intelligence-api-bucket" {
  name               = "video-intelligence-api-bucket"
}


resource "google_cloudfunctions_function" "video-intelligence-api-function" {
  name                  = "video-intelligence-api-function"
  available_memory_mb   = 128
  entry_point           = "main"
  runtime               = "python37"
  source_repository {
    url = "https://source.developers.google.com/projects/python-258010/repos/video-intelligence-api-repository/moveable-aliases/master/paths/"
  }
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = "projects/_/buckets/video-intelligence-api-bucket"
  }

}
