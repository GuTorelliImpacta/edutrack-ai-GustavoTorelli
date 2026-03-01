addon STATUS_TOKENIZACAO {
  input {
    int STATUS_TOKENIZACAO_id? {
      table = "STATUS_TTOKENIZACAO"
    }
  }

  stack {
    db.query STATUS_TTOKENIZACAO {
      where = $db.STATUS_TTOKENIZACAO.id == $input.STATUS_TOKENIZACAO_id
      return = {type: "single"}
    }
  }
}