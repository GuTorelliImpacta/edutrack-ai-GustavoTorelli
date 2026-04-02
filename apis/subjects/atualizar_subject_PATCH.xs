PATCH /subjects/:id

auth = true

handle {
  UPDATE subjects 
  SET 
    name = COALESCE($request.body.name, name),
    code = COALESCE($request.body.code, code),
    description = COALESCE($request.body.description, description),
    semester = COALESCE($request.body.semester, semester),
    workload = COALESCE($request.body.workload, workload),
    credits = COALESCE($request.body.credits, credits),
    is_active = COALESCE($request.body.is_active, is_active),
    status = COALESCE($request.body.status, status),
    updated_at = now
  WHERE id = $path.id AND user_id = $user.id
}
