// Get user record
query "auth/me" verb=GET {
  api_group = "Sabor Local"
  auth = "user"

  input {
    text email? filters=trim
    text telefone? filters=trim
  }

  stack {
    db.get user {
      field_name = "id"
      field_value = $auth.id
    } as $model
  
    precondition ($model != null) {
      error_type = "notfound"
      error = "Not Found"
    }
  }

  response = $model
}