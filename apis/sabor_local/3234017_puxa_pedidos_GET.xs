query puxa_pedidos verb=GET {
  api_group = "Sabor Local"
  auth = "user"

  input {
  }

  stack {
    db.query Pedidos {
      where = $db.Pedidos.user_id == $auth.id
      return = {type: "list"}
    } as $Pedidos1
  }

  response = $Pedidos1
}