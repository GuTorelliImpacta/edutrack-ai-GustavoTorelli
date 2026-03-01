function endereco {
  input {
  }

  stack {
    db.query dados_adicionais {
      return = {type: "list"}
      output = ["rua", "numero", "complemento"]
    } as $dados_adicionais1
  }

  response = $dados_adicionais1
}