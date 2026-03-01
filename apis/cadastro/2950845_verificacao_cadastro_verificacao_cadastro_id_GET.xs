// Get verificacao_cadastro record
query "verificacao_cadastro/{verificacao_cadastro_id}" verb=GET {
  api_group = "Cadastro"

  input {
    int verificacao_cadastro_id? filters=min:1
  }

  stack {
    db.get verificacao_cadastro {
      field_name = "id"
      field_value = $input.verificacao_cadastro_id
    } as $verificacao_cadastro
  
    precondition ($verificacao_cadastro != null) {
      error_type = "notfound"
      error = "Not Found."
    }
  }

  response = $verificacao_cadastro
}