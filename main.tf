module "network" {
  source        = "./modules/network"
  location      = var.location
  address_space = var.address_space
}
