provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = ""
  profile                 = ""
}
resource "aws_instance" "jenkins" {
  ami = "ami-02eac2c0129f6376b"
  instance_type = "t2.xlarge"
  key_name = "ivarela-demo"
  vpc_security_group_ids = [""]
  tags {
    Name = "ivarela-jenkins"
  }
  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",
      "sudo /tmp/install.sh",
    ]
  }
 connection {
    user = "centos"
    private_key = "${file("~/.ssh/id_rsa")}"
  }
}
