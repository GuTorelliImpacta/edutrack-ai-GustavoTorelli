// Add STATUS_TOKENIZAÇÃO record
query status_tokeniza_o verb=POST {
  api_group = "Sabor Local"

  input {
    dblink {
      table = "STATUS_TTOKENIZACAO"
    }
  }

  stack {
    db.add STATUS_TTOKENIZACAO {
      data = {created_at: "now"}
    } as $status_tokeniza_o
  }

  response = $status_tokeniza_o
}