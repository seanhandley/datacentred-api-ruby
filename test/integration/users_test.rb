require_relative '../test_helper'

module Datacentred
  class UsersIntegrationTest < Minitest::Test
    def setup
      @create_params_without_pass = {email: "death@afterlife2.com"}
      @create_params              = {
                                      email: "death@afterlife.com",
                                      password: "melvin11",
                                      first_name: "Foo",
                                      last_name: "Bar"
                                    }
      @create_params2             = {
                                      email: "death2@afterlife2.com",
                                      password: "melvin22"
                                    }
      @user_id                    = "bda96ae2c89347d5a059d663c153ec2a"
      @update_params              = {first_name: "Foo2"}
      @short_password             = {password:   "tiny"}
    end

    def test_user_object_properties
      VCR.use_cassette('list_users') do
        @users = Datacentred::User.all
        user = @users.first
        assert user.first_name.is_a? String
        assert user.last_name.is_a? String
        assert user.id.is_a? String
        assert user.created_at.is_a? Time
        assert user.updated_at.is_a? Time
        refute user.links
      end
    end

    def test_list_users
      VCR.use_cassette('list_users') do
        @users = Datacentred::User.all
        assert_equal 2, @users.count
      end
    end

    def test_show_user
      VCR.use_cassette('show_user') do
        @new_user = Datacentred::User.create(@create_params)
        @user = Datacentred::User.find(@new_user.id)
        assert @user.id
        assert @user.email
        assert @user.first_name
        assert @user.last_name
        assert @user.created_at
        assert @user.updated_at
      end
    end

    def test_raises_not_found_if_cant_find_user
      VCR.use_cassette('user_show_not_found') do
        assert_raises(Datacentred::Errors::NotFound) do
          @user = Datacentred::User.find("unknown")
        end
      end
    end

    def test_create_user
      VCR.use_cassette('create_user') do
        @user = Datacentred::User.create(@create_params)
        assert @user.id
        assert_equal @user.email, 'death@afterlife.com'
        assert_equal @user.first_name, "Foo"
        assert_equal @user.last_name, "Bar"
      end
    end

    def test_raises_unprocessable_entity_if_failed_validation_for_create
      VCR.use_cassette('user_create_failed_validation') do
        assert_raises(Datacentred::Errors::UnprocessableEntity) do
          @user = Datacentred::User.create(@create_params_without_pass)
        end
      end
    end

    def test_update_user_class_method
      VCR.use_cassette('update_user') do
        @user = Datacentred::User.create(@create_params)
        @user = Datacentred::User.update(@user.id, @update_params)
        assert_equal @user.first_name, 'Foo2'
      end
    end

    def test_update_user_instance_method
      VCR.use_cassette('update_user_instance_method') do
        @user = Datacentred::User.create(@create_params.merge(email: "death2@afterlife.com"))
        @user.first_name = "Foo2"
        @user.save
        assert_equal User.find(@user.id).first_name, 'Foo2'
      end
    end

    def test_raises_not_found_if_user_doesnt_exist
      VCR.use_cassette('user_update_not_found') do
        assert_raises(Datacentred::Errors::NotFound) do
          @user = Datacentred::User.update("unknown", @update_params)
        end
      end
    end

    def test_delete_user_class_method
      VCR.use_cassette('delete_user') do
        @user = Datacentred::User.create(@create_params)
        Datacentred::User.destroy(@user.id)
        assert_raises(Datacentred::Errors::NotFound) do
          @user = Datacentred::User.find(@user.id)
        end
      end
    end

    def test_delete_user_instance_method
      VCR.use_cassette('delete_user') do
        @user = Datacentred::User.create(@create_params)
        @user.destroy
        assert_raises(Datacentred::Errors::NotFound) do
          @user = Datacentred::User.find(@user.id)
        end
      end
    end
    
    def test_raises_unprocessable_entity_if_failed_validation_for_delete
      VCR.use_cassette('user_delete_failed_validation') do
        assert_raises(Datacentred::Errors::UnprocessableEntity) do
          @user = Datacentred::User.destroy("my_user_id")
        end
      end
    end

    def test_user_cant_be_deleted_if_not_found
      VCR.use_cassette('user_delete_not_found') do
        assert_raises(Datacentred::Errors::NotFound) do
          @user = Datacentred::User.destroy("unknown")
        end
      end
    end
  end
end
