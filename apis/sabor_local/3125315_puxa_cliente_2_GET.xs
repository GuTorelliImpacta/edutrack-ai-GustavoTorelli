query puxa_cliente2 verb=GET {
  api_group = "Sabor Local"
  auth = "user"

  input {
  }

  stack {
    db.query user {
      where = $db.user.id == $auth.id
      return = {type: "list"}
    } as $user1
  }

  response = $user1
}