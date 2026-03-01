query dados_adicionais verb=POST {
  api_group = "Sabor Local"
  auth = "user"

  input {
    text nomeendereco? filters=trim
    text cep? filters=trim
    text rua? filters=trim
    text bairro? filters=trim
    text numero? filters=trim
    text? complemento? filters=trim
  }

  stack {
    db.add dados_adicionais {
      data = {
        user_id     : $auth.id
        nomeendereco: $input.nomeendereco
        cep         : $input.cep
        rua         : $input.rua
        bairro      : $input.bairro
        numero      : $input.numero
        complemento : $input.complemento
      }
    } as $dados_adicionais1
  
    db.edit user {
      field_name = "id"
      field_value = $auth.id
      data = {profile_complete: true}
    } as $user2
  }

  response = $dados_adicionais1
}