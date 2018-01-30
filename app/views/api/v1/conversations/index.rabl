object false

child :paging do
  node(:page_count) { @page_count }
end

child @conversations, object_root: false do
  extends "api/v1/conversations/base"

  child :buyer => :buyer do
    extends "api/v1/users/base"
  end

  child :seller => :seller do
    extends "api/v1/users/base"
  end

  child :most_recent_message => :most_recent_message do
    attributes *Message.column_names
  end
end
