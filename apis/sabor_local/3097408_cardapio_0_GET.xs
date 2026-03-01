query Cardapio_0 verb=GET {
  api_group = "Sabor Local"
  auth = "user"

  input {
  }

  stack {
    db.query cardapio_sabor_mineiro {
      return = {type: "list"}
    } as $cardapio_sabor_mineiro1
  }

  response = $cardapio_sabor_mineiro1
}