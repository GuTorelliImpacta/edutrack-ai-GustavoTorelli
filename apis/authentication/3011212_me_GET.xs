// Get the record belonging to the authentication token
query "/me" verb=GET {
  api_group = "Authentication"
  auth = "user"

  input {
  }

  stack {
    db.get user {
      field_name = "id"
      field_value = $auth.id
      output = [
        "id"
        "created_at"
        "name"
        "telefone"
        "email"
        "is_active"
        "profile_complete"
      ]
    } as $user
  }

  response = $user
}