terraform {
  backend "s3" {
    bucket         = "myawsbucket-forterraform"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
