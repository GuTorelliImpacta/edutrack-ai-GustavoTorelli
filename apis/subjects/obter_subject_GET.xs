GET /subjects/:id

auth = true

handle {
  SELECT * FROM subjects WHERE id = $path.id AND user_id = $user.id
}
