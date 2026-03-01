table Itens {
  auth = false

  schema {
    int id
    timestamp created_at?=now
    int pedidos_id? {
      table = "Pedidos"
    }
  
    int produto_id?
    int qtd?
    decimal valor_unit?
    decimal subtotal?
    int status_item_id?
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}