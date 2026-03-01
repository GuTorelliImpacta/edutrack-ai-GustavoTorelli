query puxarpedidos verb=GET {
  api_group = "Sabor Local"

  input {
  }

  stack {
    db.query Pedidos {
      return = {type: "list"}
    } as $Pedidos1
  }

  response = $Pedidos1
}