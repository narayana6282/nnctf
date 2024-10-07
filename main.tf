provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "lms" {
  ami                    = "ami-0866a3c8686eaeeba"
  instance_type          = "t2.micro"
  key_name               = "vara"
  vpc_security_group_ids = ["sg-017a5b9518bab1a49"]
  tags = {
    Name = "nnn"

  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt install python3-pip -y",
      "sudo apt install python3-venv -y",
      "python3 -m venv /home/ubuntu/venv",
      ". /home/ubuntu/venv/bin/activate",
      "git clone https://github.com/narayana6282/nlm2.git",
      "cd nlm2",
      "pip install django",
      "sudo apt-get install libmysqlclient-dev -y",
      "sudo apt install pkg-config -y",
      "pip install mysqlclient",
      "pip  install -r requirements.txt",
      "python /home/ubuntu/nlm2/manage.py makemigrations",
      "python /home/ubuntu/nlm2/manage.py migrate",
      "python /home/ubuntu/nlm2/manage.py runserver 0.0.0.0:8000"
    ]



    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("vara.pem")
      host        = self.public_ip
    }
  }


}



