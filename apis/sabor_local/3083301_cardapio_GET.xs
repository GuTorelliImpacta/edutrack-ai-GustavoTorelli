query Cardapio verb=GET {
  api_group = "Sabor Local"

  input {
  }

  stack {
    db.query cardapio_sabor_mineiro {
      return = {type: "list"}
    } as $cardapio_sabor_mineiro1
  }

  response = $cardapio_sabor_mineiro1
}