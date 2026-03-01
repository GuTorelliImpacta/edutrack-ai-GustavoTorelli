// Query all CEP records
query cep verb=GET {
  api_group = "CEP"

  input {
  }

  stack {
    db.query "" {
      return = {type: "list"}
    } as $cep
  }

  response = $cep
}