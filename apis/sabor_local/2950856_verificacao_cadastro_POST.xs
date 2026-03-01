query verificacao_cadastro verb=POST {
  api_group = "Sabor Local"

  input {
    text name? filters=trim
    text telefone? filters=trim
    email email? filters=trim|lower
    text password? filters=trim
    text CPF? filters=trim
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
        "user_id"
        "CPF"
      ]
    } as $user2
  
    precondition (($user2|count) == 0) {
      error = "Usuário já cadastrado"
    }
  
    db.add user {
      data = {
        name                 : $input.name
        telefone             : $input.telefone
        email                : $input.email
        password             : $input.password
        is_active            : false
        profile_complete     : false
        user_id              : ""
        CPF                  : $input.CPF
        status_tokenizacao_id: "0"
      }
    
      output = [
        "id"
        "created_at"
        "name"
        "telefone"
        "email"
        "password"
        "is_active"
        "profile_complete"
        "user_id"
        "CPF"
        "status_tokenizacao_id"
      ]
    } as $user1
  
    security.random_number {
      min = 1000
      max = 9999
    } as $codigo
  
    db.add verificacao_cadastro {
      data = {
        created_at        : "now"
        codigo_verificacao: $codigo
        user_id           : $user1.id
      }
    } as $verificacao_cadastro1
  
    db.add_or_edit user {
      field_name = "id"
      field_value = $user1.id
      data = {
        name    : $input.name
        telefone: $input.telefone
        email   : $input.email
        user_id : $user1.id
        CPF     : $input.CPF
      }
    } as $user3
  
    function.run sendgrid_basic_send {
      input = {
        to_email: $input.email
        subject : "Seu Código de Verificação Restaurante Sabor Local"
        body    : "Olá, Seu código de verificação para o restaurante Sabor Local é: %s"|sprintf:$codigo
      }
    } as $func1
  }

  response = $codigo
}