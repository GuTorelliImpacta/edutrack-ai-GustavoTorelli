query finalizar_cadastro verb=POST {
  api_group = "Sabor Local"

  input {
    text email? filters=trim
    int codigo_verificacao?
  }

  stack {
    db.get user {
      field_name = "email"
      field_value = $input.email
      output = [
        "id"
        "created_at"
        "name"
        "telefone"
        "email"
        "password"
        "is_active"
      ]
    } as $utilizador_a_verificar
  
    db.query verificacao_cadastro {
      where = $db.verificacao_cadastro.user_id == $utilizador_a_verificar.id && $db.verificacao_cadastro.codigo_verificacao == $input.codigo_verificacao
      return = {type: "list"}
    } as $verificacao_cadastro1
  
    precondition ($verificacao_cadastro1.0 != null) {
      error = "Código de verificação inválido"
    }
  
    db.edit user {
      field_name = "id"
      field_value = $utilizador_a_verificar.id
      data = {is_active: true}
    } as $user1
  
    db.del verificacao_cadastro {
      field_name = "id"
      field_value = $verificacao_cadastro1.0.id
    }
  }

  response = true
}