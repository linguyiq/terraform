resource "local_file" "message" {
  content  = "Hello, World!"
  filename = "${path.module}/message.txt"
  provisioner "local-exec" {
    command = "chmod 400 ${self.filename}"
  }
}