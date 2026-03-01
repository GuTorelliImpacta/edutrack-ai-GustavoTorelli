// Edit verificacao_cadastro record
query "verificacao_cadastro/{verificacao_cadastro_id}" verb=PATCH {
  api_group = "Cadastro"

  input {
    int verificacao_cadastro_id? filters=min:1
    dblink {
      table = "verificacao_cadastro"
    }
  }

  stack {
    util.get_raw_input {
      encoding = "json"
      exclude_middleware = false
    } as $raw_input
  
    db.patch verificacao_cadastro {
      field_name = "id"
      field_value = $input.verificacao_cadastro_id
      data = `$input|pick:($raw_input|keys)`|filter_null|filter_empty_text
    } as $verificacao_cadastro
  }

  response = $verificacao_cadastro
}