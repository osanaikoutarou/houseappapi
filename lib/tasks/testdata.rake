namespace :testdata do
  desc 'Import test data (from csv)'
  task import_20170927: :environment do

    SAMPLE_PHOTO_PATH = 'https://s3-ap-northeast-1.amazonaws.com/kenchikukatachi/development/photo/image'
    SAMPLE_ARCHITECT_PHOTO_PATH = 'https://s3-ap-northeast-1.amazonaws.com/kenchikukatachi/development/architect'

    architects = {}
    CSV.foreach('sampledata/20170927/architects.csv', headers: true) do |row|
      architect_id = row[0]
      avatar_name = row[3]
      name = row[4]
      message = row[5]
      introduction = row[6]
      affiliation = row[7]
      qualifications = row[8]
      speciality = row[9]
      career = row[10]
      homepage = row[11]

      architects[architect_id] = {}
      architects[architect_id]['architect'] = {}
      architects[architect_id]['architect']['avatar'] = avatar_name.blank? ? '' : avatar_name
      architects[architect_id]['architect']['name'] = name
      architects[architect_id]['architect']['message'] = message
      architects[architect_id]['architect']['introduction'] = introduction
      architects[architect_id]['architect']['affiliation'] = affiliation
      architects[architect_id]['architect']['qualifications'] = qualifications
      architects[architect_id]['architect']['speciality'] = speciality
      architects[architect_id]['architect']['career'] = career
      architects[architect_id]['architect']['homepage'] = homepage

      architects[architect_id]['houses'] = {}

      puts "Architect id = #{architect_id} \t name = #{name}"
    end

    houses = {}
    CSV.foreach('sampledata/20170927/houses.csv', headers: true) do |row|
      house_id = row[0]
      name = row[4]
      description = row[5]
      cost = row[6]
      area = row[7]
      space = row[8]
      architect_id = row[9]

      next if architects[architect_id].blank?


      # House belongs to architect. Architect has many houses
      houses[house_id] = {}
      houses[house_id]['name'] = name
      houses[house_id]['description'] = description
      #houses[house_id]['cost'] = cost
      houses[house_id]['area'] = area
      houses[house_id]['floor_space'] = space

      houses[house_id]['photos'] = {}

      architects[architect_id]['houses'][house_id] = houses[house_id]
    end

    photos = {}
    CSV.foreach('sampledata/20170927/photos.csv', headers: true) do |row|
      photo_id = row[0]
      title = row[2]
      image_name = row[3]
      description = row[6]
      house_id = row[10]

      next if houses[house_id].blank?

      # Each house has many photos
      photos[photo_id] = {}
      photos[photo_id]['title'] = title
      photos[photo_id]['image_name'] = image_name
      photos[photo_id]['description'] = description

      houses[house_id]['photos'][photo_id] = photos[photo_id]
    end

    houses.each_pair do |house_id, house|
      puts "House id = #{house_id} \t photo_count = #{houses[house_id]['photos'].length} \t #{house['title']} "
    end

    architects.each_pair do |architect_id, value|

      photo_count = 0
      architects[architect_id]['houses'].each_pair do |house_id, house|
        photo_count += houses[house_id]['photos'].length
      end

      puts "Architect #{architect_id}: house_count = #{architects[architect_id]['houses'].length}, photo_count = #{photo_count}"
    end
    # Import into DB

    architect_count = 0
    architects.each_pair do |architect_id, hash|
      a = Architect.create(hash['architect'])
      begin

        a.remote_avatar_url = "#{SAMPLE_ARCHITECT_PHOTO_PATH}/#{hash['architect']['avatar']}" unless hash['architect']['avatar'].blank?
        a.save!
      rescue
        puts " ... (failed to upload image) ... #{a.remote_avatar_url}"
        a.remote_avatar_url = nil
      end

      a.save!
      architect_count += 1
      puts "---------------------------------------"
      puts "Imported new architect #{a.id} (#{architect_count} / #{architects.length})"

      house_count = 0
      hash['houses'].each_pair do |house_id, house|
        h = House.new()
        h.architect_id = a.id
        h.name = house['name']
        h.description = house['description']
        h.area = house['area']
        h.floor_space = house['floor_space']

        h.save!

        house_count += 1
        puts "Saved new house (#{house_count} / #{architects[architect_id]['houses'].length}) for architect #{a.id}. Start uploading photos (#{house['photos'].length} photos)"

        photo_count = 0
        houses[house_id]['photos'].each_pair do |house_id, photo|
          puts " -> uploading #{photo_count} / #{house['photos'].length}"
          p = Photo.new()
          p.house_id = h.id
          p.title = photo['title']
          p.description = photo['description']
          begin
            p.remote_image_url = "#{SAMPLE_PHOTO_PATH}/#{photo['image_name']}" unless photo['image_name'].blank?
            p.save!
          rescue
            puts " ... (failed to upload image) ... #{p.remote_image_url}"
            p.remote_image_url = nil
          end
          p.save!
          photo_count += 1
        end
        puts "Uploaded photos for architect #{a.id} ---|"
      end
    end
  end
end
