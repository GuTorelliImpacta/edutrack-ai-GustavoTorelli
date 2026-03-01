query meus_enderecos verb=GET {
  api_group = "Sabor Local"
  auth = "user"

  input {
    text nomeendereco? filters=trim
    text cep? filters=trim
    text rua? filters=trim
    text numero? filters=trim
    text complemento? filters=trim
  }

  stack {
    db.query dados_adicionais {
      where = $db.dados_adicionais.user_id == $auth.id
      return = {type: "list"}
    } as $dados_adicionais1
  }

  response = $dados_adicionais1
}