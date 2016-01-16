class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
    #  t.wiki_id :integer
    #  t.user_id :integer
      t.references :user, index: true, foreign_key: true
      t.references :wiki, index: true, foreign_key: true

      t.timestamps null: false
    end

  end
end
