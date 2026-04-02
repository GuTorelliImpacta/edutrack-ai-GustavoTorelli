DELETE /subjects/:id

auth = true

handle {
  DELETE FROM subjects WHERE id = $path.id AND user_id = $user.id
}
