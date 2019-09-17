resource "aws_subnet" "subnet" {
  for_each   = var.subnet_addresses
  vpc_id     = var.vpc_id
  cidr_block = (each.value)

  tags = {
    Terraform = "true"
    Name      = "${var.subnet_group}Subnet${each.key}"
  }
}

# Associate subnet to route table
resource "aws_route_table_association" "subnet_route_table_association" {
  for_each       = var.subnet_addresses
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = element(var.route_table_id, each.key - 1)
}
