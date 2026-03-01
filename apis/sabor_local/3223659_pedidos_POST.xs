query pedidos verb=POST {
  api_group = "Sabor Local"
  auth = "user"

  input {
    int dados_adicionais_id? {
      table = "dados_adicionais"
    }
  
    text[1:10] itens? filters=trim
    decimal valor_subtotal?
    decimal valor_total?
    text[1:3] rua? filters=trim
    int[] quantidadeItens?
    text numero? filters=trim
    text? complemento? filters=trim
  }

  stack {
    db.add Pedidos {
      data = {
        created_at         : "now"
        dados_adicionais_id: $input.dados_adicionais_id
        user_id            : $auth.id
        itens              : $input.itens
        quantidadeItens    : $input.quantidadeItens
        subtotal_itens     : $input.valor_subtotal
        total              : $input.valor_total
        status_pedido      : "Criado"
        rua                : $input.rua
        numero             : $input.numero
        complemento        : $input.complemento
      }
    
      output = [
        "id"
        "created_at"
        "dados_adicionais_id"
        "user_id"
        "itens"
        "subtotal_itens"
        "total"
        "status_pedido"
        "endereco"
      ]
    } as $novo_pedido
  }

  response = $novo_pedido
}