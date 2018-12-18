resource "aws_security_group" "sg-firewall" {
  name        = "${var.PREFIX}-${var.NAME}"
  description = "Security group configuration to open LB firewall ports"
  vpc_id      = "${data.aws_vpc.virginia_default_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming connections for SSH over IPv4/IPV6"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming connections for trafic over IPv4/IPV6"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow incoming connections for Linkerd admin UI"
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    self        = true
    description = "Allow incoming connections for linkerd-viz"
  }

  ingress {
    from_port   = 4140
    to_port     = 4140
    protocol    = "tcp"
    self        = true
    description = "Allow incoming connections for linkerd"
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    description = "Allow incoming internet-facing connections for Consul"
  }

  ingress {
    from_port   = 9990
    to_port     = 9990
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    description = "Allow incoming internet-facing connections for Linkerd"
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    description = "Allow incoming internet-facing connections for Grafana"
  }

  ingress {
    from_port   = 8301 
    to_port     = 8301
    self        = true
    protocol    = "tcp"
    description = "Allow incoming local connections for consul agent"
  }

  ingress {
    from_port   = 8400
    to_port     = 8400
    self        = true
    protocol    = "tcp"
    description = "Allow incoming local connections for consul agent"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.PREFIX}-${var.NAME}"
    Environment = "${var.ENVRIOMENT}"
  }
}
