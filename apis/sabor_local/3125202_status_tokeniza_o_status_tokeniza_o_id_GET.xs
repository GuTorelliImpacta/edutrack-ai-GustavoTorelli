// Get STATUS_TOKENIZAÇÃO record
query "status_tokeniza_o/{status_tokeniza_o_id}" verb=GET {
  api_group = "Sabor Local"

  input {
    int status_tokeniza_o_id? filters=min:1
  }

  stack {
    db.get STATUS_TTOKENIZACAO {
      field_name = "id"
      field_value = $input.status_tokeniza_o_id
    } as $status_tokeniza_o
  
    precondition ($status_tokeniza_o != null) {
      error_type = "notfound"
      error = "Not Found."
    }
  }

  response = $status_tokeniza_o
}