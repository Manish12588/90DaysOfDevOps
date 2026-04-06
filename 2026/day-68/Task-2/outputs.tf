output "public_ip" {
  value = {
    for key, value in aws_instance.my_instance : key => {
      public_ip = value.public_ip
      user      = var.instances[key].user
    }
  }

}
