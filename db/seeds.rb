user = User.new(email: "admin@4asset.com")

password = "Senha123"

user.password = password
user.password_confirmation = password

user.save
