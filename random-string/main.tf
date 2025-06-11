resource "random_string" "my_random" {
    length  = 16
    special = false
    upper   = false
    lower   = true
    keepers = {
        always = timestamp()
    }
}