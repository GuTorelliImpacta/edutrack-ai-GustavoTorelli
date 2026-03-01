// Add verificacao_cadastro record
query verificacao_cadastro verb=POST {
  api_group = "Cadastro"

  input {
    dblink {
      table = "verificacao_cadastro"
    }
  }

  stack {
    db.add verificacao_cadastro {
      data = {created_at: "now"}
    } as $verificacao_cadastro
  }

  response = $verificacao_cadastro
}