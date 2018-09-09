class AddDigestToWebsites < ActiveRecord::Migration[5.2]
  def change
    add_column :websites, :digest, :string
  end
end
