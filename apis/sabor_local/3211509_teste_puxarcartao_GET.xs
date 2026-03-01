query teste_puxarcartao verb=GET {
  api_group = "Sabor Local"
  auth = "user"

  input {
  }

  stack {
    db.query TTOKENIZACAO {
      where = $db.TTOKENIZACAO.cliente_id == $auth.id
      return = {type: "list"}
    } as $TTOKENIZACAO1
  }

  response = $TTOKENIZACAO1
}