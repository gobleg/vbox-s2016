class AddAttachmentDashVideoToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :dash_video
    end
  end

  def self.down
    remove_attachment :videos, :dash_video
  end
end
