class RemoveSubjectFromShadowSpots < ActiveRecord::Migration
  def change
    remove_column :shadow_spots, :subject
  end
end
