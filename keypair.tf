resource "aws_key_pair" "dev-key" {
  key_name   = "dev-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvLL9kRAe0DVHMzggjo0Bpk8aifEHjoI+m2IjPrfAiD enggv@Enggville"
}