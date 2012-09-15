class AddIndexToSearchapps < ActiveRecord::Migration
  def up
    execute "create index searchapps_file_name on searchapps using gin(to_tsvector('english', file_name))"
    execute "create index searchapps_content on searchapps using gin(to_tsvector('english', content))"
  end

  def down
    execute "drop index searchapps_name"
    execute "drop index searchapps_content"
  end
end
