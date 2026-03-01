// Delete verificacao_cadastro record.
query "verificacao_cadastro/{verificacao_cadastro_id}" verb=DELETE {
  api_group = "Cadastro"

  input {
    int verificacao_cadastro_id? filters=min:1
  }

  stack {
    db.del verificacao_cadastro {
      field_name = "id"
      field_value = $input.verificacao_cadastro_id
    }
  }

  response = null
}