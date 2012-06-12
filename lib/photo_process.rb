#!/usr/bin/env ruby

ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../config/environment"

logger = Logger.new("#{Rails.root}/log/photo_process.log")

logger.info("Starting Daemon #{Time.now}")

loop do
  sleep(5)
  logger.info(ScheduledPhoto.count)

  if ScheduledPhoto.where(:status => 'pending').count == 0
    logger.info("#{Time.now} - Nothing to do, sleeping")
    next
  end

  ScheduledPhoto.find_each(:conditions => { :status => 'pending' }, :batch_size => 5 ) do |scheduled_photo|


      logger.info("#{Time.now} - Processing photo #{scheduled_photo.photo_path}")
      scheduled_photo.update_attribute(:status, 'running')

      gallery = scheduled_photo.gallery
      photo   = gallery.photos.build(:user_id => scheduled_photo.user_id)
      photo.save

      original_photo_path = Rails.public_path + '/' + scheduled_photo.photo_path
      original_filename   = original_photo_path.split('/').last
      gallery_dir         = Rails.public_path + gallery.directory_path
      gallery_photo_dir   = gallery_dir + "/#{photo.id}"

      begin
        photo.update_attributes(:photo_file_name    => original_filename,
                                :photo_content_type => original_filename[-3,3],
                                :photo_file_size    => File.size(original_photo_path))
        photo.generate_identifier
        photo.save

        #make sure that gallery dir exist or create
        Dir.mkdir(gallery_dir) unless File.directory?(gallery_dir)

        #create photo directory
        Dir.mkdir(gallery_photo_dir) unless File.directory?(gallery_photo_dir)

        #http://www.imagemagick.org/script/command-line-processing.php#geometry
        photo_options = {
          :mini => {
            :geometry => '124x124!',
            :quality => 85,
            :format => 'jpg'
          },
          :small => {
            :geometry => '160x160',
            :quality => 85,
            :format => 'JPG'
          },
          :thumb => {
            :geometry => '200x200',
            :quality => 100
          },
          :medium => {
            :geometry => '400x400',
            :quality => 100
          },
          :large => {
            :geometry => '800x700>',
            :quality => 100
          }
        }

        photo_options.each do |size, options|
          Dir.mkdir(gallery_photo_dir + "/#{size.to_s}") unless File.directory?(gallery_photo_dir + "/#{size.to_s}")
          #TODO rescue
          image = MiniMagick::Image.open(original_photo_path)

          case size
            when :mini
              if image[:width] < image[:height]
                remove = ((image[:height] - image[:width])/2).round
                image.shave("0x#{remove}")
              elsif image[:width] > image[:height]
                remove = ((image[:width] - image[:height])/2).round
                image.shave("#{remove}x0")
              end
              image.resize("#{124}x#{124}")
            when :large
              if image[:height] > image[:width]
                image.resize '400x600>'
              else
                image.resize options[:geometry]
              end
            else
              image.resize options[:geometry]
          end

          image.write  gallery_photo_dir + "/#{size.to_s}/" + original_filename
        end

        logger.info("#{Time.now} - Processing photo #{scheduled_photo.photo_path} finished")
        scheduled_photo.update_attribute(:status, 'finished')
      rescue => e
        logger.info("#{Time.now} - !!! Processing photo #{scheduled_photo.photo_path} failed !!!")
        logger.info("Error: #{e.inspect}")
        scheduled_photo.update_attributes(:status => 'failed', :log => e.inspect)
        photo.destroy
      end

  end

end
