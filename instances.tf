resource "aws_instance" "nginx1" {
  ami           = "ami-0cb790308f7591fa6"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public-subnet-2.id}"
  vpc_security_group_ids = ["${aws_security_group.http.id}"]
}

resource "aws_instance" "nginx2" {
  ami           = "ami-0cb790308f7591fa6"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  vpc_security_group_ids = ["${aws_security_group.http.id}"]
}


resource "aws_instance" "bastion" {
  ami           = "ami-0cb790308f7591fa6"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
}

resource "aws_instance" "db-server" {
  ami           = "ami-0cb790308f7591fa6"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.private-subnet-1.id}"
  vpc_security_group_ids = ["${aws_security_group.private-ssh.id}"]
}