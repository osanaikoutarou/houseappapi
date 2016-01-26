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

Photo.create(:id=>'012', :uuid=>'abcde', :title=>'たいとる111', :image_url=>'a000001_h0000001_img000000001.jpg', :liked_count=>12, :passed_count=>2345, :description=>'説明文1説明文');
Photo.create(:id=>'013', :uuid=>'fghijk', :title=>'タイトル222', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123, :passed_count=>23456, :description=>'説明文2説明文');
Photo.create(:id=>'013', :uuid=>'lmnopq', :title=>'たいとる333', :image_url=>'a000001_h0000001_img000000001.jpg', :liked_count=>1234, :passed_count=>234567, :description=>'説明文3説明文');
Photo.create(:id=>'014', :uuid=>'rstuvw', :title=>'タイトル444', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>12345, :passed_count=>2345678, :description=>'説明文4説明文');
Photo.create(:id=>'015', :uuid=>'xyz012', :title=>'タイトル555', :image_url=>'a000001_h0000001_img000000002.jpg', :liked_count=>123456, :passed_count=>23456789, :description=>'説明文5説明文');

#Book.create(:title=>"たいとる01");

#Email.create(:subject=>"subject" , :body=>"body");

# aaa
