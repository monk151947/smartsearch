class AddIndexToAssets < ActiveRecord::Migration
  def up
    execute "create index assets_content on searchapps using gin(to_tsvector('english', content))"
  end

  def down
   execute "drop index assets_content"
  end
end
