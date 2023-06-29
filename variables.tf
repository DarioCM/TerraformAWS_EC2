
variable "ec2size" {
  type = string
  default = "t2.micro"
  description = "Small server. 1Gb 1vCPU"
}

variable "keyName" {
  default = "TJC"
}

variable "keyPath" {
  default = "~/tjc.pem"
}