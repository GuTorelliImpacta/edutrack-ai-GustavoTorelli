POST /subjects

auth = true

handle {
  INSERT INTO subjects (name, code, description, semester, workload, credits, user_id, owner, is_active, status)
  VALUES ($request.body.name, $request.body.code, $request.body.description, $request.body.semester, $request.body.workload, $request.body.credits, $user.id, $user.id, true, 'active')
}
