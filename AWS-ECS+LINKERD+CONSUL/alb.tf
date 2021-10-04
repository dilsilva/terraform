resource "aws_lb" "load_balancer" {
  name            = "${var.PREFIX}-${var.NAME}-alb"
  security_groups = ["${aws_security_group.sg-firewall.id}"]
  subnets         = ["${data.aws_subnet_ids.public_subs.ids}"]

  tags {
    Name        = "${var.PREFIX}-${var.NAME}"
    Environment = "${var.ENVRIOMENT}"
  }
}

resource "aws_lb_target_group" "target_group" {
  name       = "${var.PREFIX}-${var.NAME}-tg"
  port       = 9990
  protocol   = "HTTP"
  vpc_id     = "${data.aws_vpc.virginia_default_vpc.id}"
  depends_on = ["aws_lb.load_balancer"]

  tags {
    Name        = "${var.PREFIX}-${var.NAME}"
    Environment = "${var.ENVRIOMENT}"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_lb.load_balancer.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
    type             = "forward"
  }
}
