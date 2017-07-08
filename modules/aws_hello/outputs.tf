output "aws_hello_endpoint" {
  value = [ "${ aws_instance.hello.public_ip }" ]
}
