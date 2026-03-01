// Query all verificacao_cadastro records
query verificacao_cadastro verb=GET {
  api_group = "Cadastro"

  input {
  }

  stack {
    db.query verificacao_cadastro {
      return = {type: "list"}
    } as $verificacao_cadastro
  }

  response = $verificacao_cadastro
}