table cardapio_sabor_mineiro {
  auth = false

  schema {
    int id
    text item?
    text descricao?
    text categoria?
    text preco?
    image? foto?
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "gin", field: [{name: "xdo", op: "jsonb_path_op"}]}
  ]
}