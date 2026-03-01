query excluir_cartao verb=DELETE {
  api_group = "Sabor Local"
  auth = "user"

  input {
  }

  stack {
    db.query CARTAOTOKNZD {
      where = $db.CARTAOTOKNZD.cliente_id == $auth.id
      return = {type: "list"}
    } as $lista_cartoes
  
    foreach ($lista_cartoes) {
      each as $item {
        db.del CARTAOTOKNZD {
          field_name = "id"
          field_value = $item.id
        }
      }
    }
  
    db.query TTOKENIZACAO {
      where = $db.TTOKENIZACAO.cliente_id == $auth.id
      return = {type: "list"}
    } as $lista_transacoes
  
    foreach ($lista_transacoes) {
      each as $item {
        db.del TTOKENIZACAO {
          field_name = "id"
          field_value = $item.id
        }
      }
    }
  }

  response = $lista_cartoes
}