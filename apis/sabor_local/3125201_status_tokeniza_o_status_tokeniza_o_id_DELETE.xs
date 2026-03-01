// Delete STATUS_TOKENIZAÇÃO record.
query "status_tokeniza_o/{status_tokeniza_o_id}" verb=DELETE {
  api_group = "Sabor Local"

  input {
    int status_tokeniza_o_id? filters=min:1
  }

  stack {
    db.del STATUS_TTOKENIZACAO {
      field_name = "id"
      field_value = $input.status_tokeniza_o_id
    }
  }

  response = null
}