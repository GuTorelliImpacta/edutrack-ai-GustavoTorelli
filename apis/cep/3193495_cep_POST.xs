// Add CEP record
query cep verb=POST {
  api_group = "CEP"

  input {
    dblink {
      table = ""
    }
  }

  stack {
    db.add "" {
      data = {created_at: "now"}
    } as $cep
  }

  response = $cep
}