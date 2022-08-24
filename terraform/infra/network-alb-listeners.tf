resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.lb_instance.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_group.arn
  }
}


## Cannot be applied in the first moment because
## the certificate can only be attached to listener
## if it is valid, but the validation must to be 
## made manually on DNS provider

# resource "aws_lb_listener" "lb_listener_https" {
#   load_balancer_arn = aws_lb.lb_instance.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.acm_certificate.arn
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.lb_group.arn
#   }
# }