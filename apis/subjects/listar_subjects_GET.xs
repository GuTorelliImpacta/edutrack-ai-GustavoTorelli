GET /subjects

auth = true

handle {
  SELECT * FROM subjects WHERE user_id = $user.id ORDER BY created_at DESC
}
