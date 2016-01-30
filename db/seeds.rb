# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Photo.create(:uuid=>'uuid001' , :image_url=>'http://imageurl001' , :title=>'タイトル01' , :like=>true , :pass=>false , :liked_count=>123 , :passed_count => 9876 , :description=>"説明文テスト01");
#Photo.create(:uuid=>'uuid002' , :image_url=>'http://imageurl002' , :title=>'タイトル02' , :like=>true , :pass=>false , :liked_count=>456 , :passed_count => 5432 , :description=>"説明文テスト02");
#Photo.create(:uuid=>'uuid003' , :image_url=>'http://imageurl003' , :title=>'タイトル03' , :like=>true , :pass=>false , :liked_count=>789 , :passed_count => 1234 , :description=>"説明文テスト03");

#Photo.create(:title=>'タイトル01' , :description=>"説明文テスト01");
#Photo.create(:liked_count=>456 , :passed_count => 5432);
#Photo.create(:image_url=>'http://imageurl003' , :title=>'タイトル03' , :like=>true , :pass=>false , :liked_count=>789 , :passed_count => 1234 , :description=>"説明文テスト03");

#Photo.create(:uuid=>'abcde', :title=>'たいとる111', :image_url=>'a000001_h0000001_img000000001.jpg', :liked_count=>12, :passed_count=>2345, :description=>'説明文1説明文');
#Photo.create(:uuid=>'fghijk', :title=>'タイトル222', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123, :passed_count=>23456, :description=>'説明文2説明文');
#Photo.create(:uuid=>'lmnopq', :title=>'たいとる333', :image_url=>'a000001_h0000001_img000000001.jpg', :liked_count=>1234, :passed_count=>234567, :description=>'説明文3説明文');
#Photo.create(:uuid=>'rstuvw', :title=>'タイトル444', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>12345, :passed_count=>2345678, :description=>'説明文4説明文');
#Photo.create(:uuid=>'xyz012', :title=>'タイトル555', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123456, :passed_count=>23456789, :description=>'説明文5説明文');

#Book.create(:title=>"たいとる01");

#Email.create(:subject=>"subject" , :body=>"body");

#建築家
architect1 = Architect.create(:uuid=>'architect1',:liked_count=>111,:icon_url=>"image/architect_icon/01.jpg",:name=>"建築家名1",:description=>"建築家名の説明文1");
architect2 = Architect.create(:uuid=>'architect2',:liked_count=>222,:icon_url=>"image/architect_icon/02.jpg",:name=>"建築家名2",:description=>"建築家名の説明文2");

#家
house1 = House.create(:uuid=>'houseuuid1', :view_count=>1111, :liked_count=>111, :title=>"家名1", :description=>"家1の説明文です");
house2 = House.create(:uuid=>'houseuuid2', :view_count=>2222, :liked_count=>222, :title=>"家名2", :description=>"家2の説明文です");
house3 = House.create(:uuid=>'houseuuid3', :view_count=>3333, :liked_count=>333, :title=>"家名3", :description=>"家3の説明文です");
house4 = House.create(:uuid=>'houseuuid4', :view_count=>4444, :liked_count=>444, :title=>"家名4", :description=>"家4の説明文です");
house5 = House.create(:uuid=>'houseuuid5', :view_count=>5555, :liked_count=>555, :title=>"家名5", :description=>"家5の説明文です");

#画像
photo1 = Photo.create(:uuid=>'abcde', :title=>'たいとる111', :image_url=>'a000001_h0000001_img000000001.jpg', :liked_count=>12, :passed_count=>2345, :description=>'説明文1説明文');
photo2 = Photo.create(:uuid=>'fghijk', :title=>'タイトル222', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123, :passed_count=>23456, :description=>'説明文2説明文');
photo3 = Photo.create(:uuid=>'lmnopq', :title=>'たいとる333', :image_url=>'a000001_h0000001_img000000001.jpg', :liked_count=>1234, :passed_count=>234567, :description=>'説明文3説明文');
photo4 = Photo.create(:uuid=>'rstuvw', :title=>'タイトル444', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>12345, :passed_count=>2345678, :description=>'説明文4説明文');
photo5 = Photo.create(:uuid=>'xyz012', :title=>'タイトル555', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123456, :passed_count=>23456789, :description=>'説明文5説明文');
photo6 = Photo.create(:uuid=>'xyz345', :title=>'タイトル666', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123456, :passed_count=>23456789, :description=>'説明文5説明文');
photo7 = Photo.create(:uuid=>'xyz678', :title=>'タイトル777', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123456, :passed_count=>23456789, :description=>'説明文5説明文');
photo8 = Photo.create(:uuid=>'xyz901', :title=>'タイトル888', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123456, :passed_count=>23456789, :description=>'説明文5説明文');

architect1.houses << house1
architect1.houses << house2
architect1.houses << house3
architect2.houses << house4
architect2.houses << house5

house1.photos << photo1
house1.photos << photo2
house1.photos << photo3
house2.photos << photo4
house2.photos << photo5
house3.photos << photo6
house4.photos << photo7
house5.photos << photo8

