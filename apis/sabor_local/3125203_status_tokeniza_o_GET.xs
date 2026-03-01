// Query all STATUS_TOKENIZAÇÃO records
query status_tokeniza_o verb=GET {
  api_group = "Sabor Local"

  input {
  }

  stack {
    db.query STATUS_TTOKENIZACAO {
      return = {type: "list"}
    } as $status_tokeniza_o
  }

  response = $status_tokeniza_o
}