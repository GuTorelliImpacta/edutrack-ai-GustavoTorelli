// Edit STATUS_TOKENIZAÇÃO record
query "status_tokeniza_o/{status_tokeniza_o_id}" verb=PATCH {
  api_group = "Sabor Local"

  input {
    int status_tokeniza_o_id? filters=min:1
    dblink {
      table = "STATUS_TTOKENIZACAO"
    }
  }

  stack {
    util.get_raw_input {
      encoding = "json"
      exclude_middleware = false
    } as $raw_input
  
    db.patch STATUS_TTOKENIZACAO {
      field_name = "id"
      field_value = $input.status_tokeniza_o_id
      data = `$input|pick:($raw_input|keys)`|filter_null|filter_empty_text
    } as $status_tokeniza_o
  }

  response = $status_tokeniza_o
}