resource "local_file" "name" {
  content  = "test_content"
  filename = "${path.module}/file.txt"
}
