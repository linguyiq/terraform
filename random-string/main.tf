resource "random_string" "my_random" {
    length  = 16
    special = false
    upper   = false
    lower   = true
    number  = true
    keepers = {
        always = timestamp()
    }
  
}