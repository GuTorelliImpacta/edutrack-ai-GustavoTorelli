// Query all TTOKENIZACAO records
query ttokenizacao verb=GET {
  api_group = "Sabor Local"

  input {
  }

  stack {
    db.query TTOKENIZACAO {
      return = {type: "list"}
    } as $ttokenizacao
  }

  response = $ttokenizacao
}