// Get cardapio_sabor_mineiro record
query "cardapio_sabor_mineiro/{cardapio_sabor_mineiro_id}" verb=GET {
  api_group = "Sabor Local"

  input {
    int cardapio_sabor_mineiro_id? filters=min:1
  }

  stack {
    db.get cardapio_sabor_mineiro {
      field_name = "id"
      field_value = $input.cardapio_sabor_mineiro_id
    } as $model
  
    precondition ($model != null) {
      error_type = "notfound"
      error = "Not Found"
    }
  }

  response = $model
}