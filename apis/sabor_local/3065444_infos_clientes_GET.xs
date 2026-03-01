query infos_clientes verb=GET {
  api_group = "Sabor Local"

  input {
  }

  stack {
    db.query user {
      return = {type: "list"}
    } as $user1
  }

  response = $user1
}