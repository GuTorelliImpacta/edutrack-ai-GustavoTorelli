// Login and retrieve an authentication token
query "auth/login" verb=POST {
  api_group = "Sabor Local"

  input {
    email email? filters=trim|lower
    text password?
  }

  stack {
    db.get user {
      field_name = "email"
      field_value = $input.email
      output = [
        "id"
        "created_at"
        "name"
        "telefone"
        "email"
        "password"
        "is_active"
      ]
    } as $user
  
    precondition ($user.is_active) {
      error = "A sua conta ainda não foi ativada."
    }
  
    precondition ($user != null) {
      error_type = "accessdenied"
      error = "Invalid Credentials."
    }
  
    security.check_password {
      text_password = $input.password
      hash_password = $user.password
    } as $pass_result
  
    precondition ($pass_result) {
      error_type = "accessdenied"
      error = "Invalid Credentials."
    }
  
    security.create_auth_token {
      table = "user"
      extras = {}
      expiration = 864000
      id = $user.id
    } as $authToken
  }

  response = {authToken: $authToken}
}