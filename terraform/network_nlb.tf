resource "aws_lb" "public_nlb" {
  name               = "app-server-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [module.network.pub_sn_zone_1]
}

resource "aws_lb_target_group" "aws_nlb_tg" {
  name     = "app-server-lb-tg"
  port     = 3000
  protocol = "TCP"
  vpc_id   = module.network.vpc_main_id
}

resource "aws_lb_target_group_attachment" "aws_nlb_tg_attach" {
  target_group_arn = aws_lb_target_group.aws_nlb_tg.arn
  target_id        = aws_instance.app_server.id
  port             = 3000
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.public_nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_nlb_tg.arn
  }
}
