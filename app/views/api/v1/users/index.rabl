object false

child :paging do
  node(:total_pages) { @total_pages }
end

child @users, object_root: false do
  extends "api/v1/users/base"
end
