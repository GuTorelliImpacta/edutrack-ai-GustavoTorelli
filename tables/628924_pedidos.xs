table Pedidos {
  auth = false

  schema {
    int id
    timestamp created_at?=now {
      visibility = "private"
    }
  
    int dados_adicionais_id? {
      table = "dados_adicionais"
    }
  
    int user_id? {
      table = "user"
    }
  
    text[1:10] itens? filters=trim
    int[] quantidadeItens?
    decimal subtotal_itens?
    decimal total?
    text status_pedido? filters=trim
    text[1:4] rua? filters=trim
    text numero? filters=trim
    text? complemento? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}