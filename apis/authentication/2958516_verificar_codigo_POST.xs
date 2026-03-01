query verificar_codigo verb=POST {
  api_group = "Authentication"

  input {
    email email? filters=trim|lower
    int codigo_verificacao?
  }

  stack {
    db.get verificacao_cadastro {
      field_name = "email"
      field_value = $input.email
      output = [
        "id"
        "created_at"
        "name"
        "telefone"
        "email"
        "password"
        "codigo_verificacao"
        "expires_at"
      ]
    } as $pedido_verificacao
  
    precondition ($input.codigo_verificacao == $pedido_verificacao.codigo_verificacao) {
      error = "Código de verificação inválido"
    }
  }

  response = $pedido_verificacao
}