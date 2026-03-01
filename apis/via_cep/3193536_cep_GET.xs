// Query all CEP records
query cep verb=GET {
  api_group = "ViaCEP"

  input {
  }

  stack {
    db.query CEP {
      return = {type: "list"}
    } as $cep
  }

  response = $cep
}