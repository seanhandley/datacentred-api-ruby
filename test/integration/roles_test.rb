require_relative '../test_helper'

module Datacentred
  class RolesIntegrationTest < Minitest::Test
    def setup
      @create_params1      = {name: "New Role"}
      @create_params2      = {name: "Historical Figures",
                              permissions: ["usage.read","tickets.modify"]}
      @new_permissions     = {permissions: ['usage.read',
                                            'roles.modify', 'roles.read']}
      @invalid_permissions = {name: "Genghis Khan",
                              permissions: ["fighting"]}
      @user_id             = "06eacbafda355a927f50f304db3af132"
    end

    def test_list_roles
      VCR.use_cassette('list_roles') do
        @roles = Datacentred::Role.all
        assert_equal 2, @roles.count
        @role = @roles.first
        assert @role.id
        assert @role.name
        assert @role.permissions
      end
    end

    def test_find_role
      VCR.use_cassette('find_role') do
        @new_role = Datacentred::Role.create(@create_params1)
        @role = Datacentred::Role.find(@new_role.id)
        assert_equal @role.name, "New Role"
      end
    end

    def test_create_role_without_permissions
      VCR.use_cassette('create_role_without_permissions') do
        @new_role = Datacentred::Role.create(@create_params1)
        assert_equal @new_role.name, "New Role"
      end
    end

    def test_create_role_with_permissions
      VCR.use_cassette('create_role_with_permissions') do
        @new_role = Datacentred::Role.create(@create_params2)
        assert_equal @new_role.name, "Historical Figures"
      end
    end

    def test_create_role_with_invalid_permissions
      VCR.use_cassette('create_role_with_invalid_permissions') do
        assert_raises(Datacentred::Errors::UnprocessableEntity) do
          @role = Datacentred::Role.create(@invalid_permissions)
        end
      end
    end

    def test_update_role_with_class_method
      VCR.use_cassette('update_role') do
        @role = Datacentred::Role.create(@create_params1)
        assert_equal @role.name, 'New Role'
        @updated_role = Datacentred::Role.update(@role.id, {name: "Administrator 2"})
        assert_equal @updated_role.name, 'Administrator 2'
      end
    end

    def test_update_role_with_instance_method
      VCR.use_cassette('update_role_instance_method') do
        @role = Datacentred::Role.create(@create_params1)
        assert_equal @role.name, 'New Role'
        @role.name = "Administrator 2"
        @role.save
        assert_equal 'Administrator 2', Datacentred::Role.find(@role.id).name
      end
    end

    def test_update_role_with_invalid_permissions
      VCR.use_cassette('update_role_with_invalid_permissions') do
        @role = Datacentred::Role.create(@create_params1)
        assert_raises(Datacentred::Errors::UnprocessableEntity) do
          Datacentred::Role.update(@role.id, @invalid_permissions)
        end
      end
    end

    def test_delete_role_with_class_method
      VCR.use_cassette('delete_role') do
        @role = Datacentred::Role.create(@create_params1)
        assert Datacentred::Role.find(@role.id)
        assert_equal true, Datacentred::Role.destroy(@role.id)
        assert_raises(Datacentred::Errors::NotFound) do
          @role = Datacentred::Role.find(@role.id)
        end
      end
    end

    def test_delete_role_with_instance_method
      VCR.use_cassette('delete_role') do
        @role = Datacentred::Role.create(@create_params1)
        assert Datacentred::Role.find(@role.id)
        assert_equal true, @role.destroy
        assert_raises(Datacentred::Errors::NotFound) do
          @role = Datacentred::Role.find(@role.id)
        end
      end
    end

    def test_list_role_users_class_method
      VCR.use_cassette('list_role_users') do
        @role = Datacentred::Role.create(@create_params1)
        @user_list = Datacentred::Role.users(@role.id)
        assert_equal @user_list.count, 0
      end
    end

    def test_list_role_users_instance_method
      VCR.use_cassette('list_role_users') do
        @role = Datacentred::Role.create(@create_params1)
        assert_equal @role.users.count, 0
      end
    end

    def test_add_user_to_role_class_method
      VCR.use_cassette('add_user_to_role') do
        @role = Datacentred::Role.create(@create_params1)
        @user_list = Datacentred::Role.users(@role.id)
        assert_equal @user_list.count, 0
        assert Datacentred::Role.add_user role_id: @role.id, user_id: @user_id
        @new_users_list = Datacentred::Role.users(@role.id)
        assert_equal @new_users_list.count, 1
        assert_equal @new_users_list.first.id, @user_id
      end
    end

    def test_add_user_to_role_instance_method
      VCR.use_cassette('add_user_to_role_instance_method') do
        @role = Datacentred::Role.create(@create_params1)
        assert_equal @role.users.count, 0
        @user = Datacentred::User.all.first
        assert @role.add_user @user
        @new_users_list = @role.users
        assert_equal @new_users_list.count, 1
        assert_equal @new_users_list.first.id, @user.id
      end
    end

    def test_remove_user_from_role_class_method
      VCR.use_cassette('remove_user_from_role') do
        @role = Datacentred::Role.create(@create_params1)
        assert Datacentred::Role.add_user role_id: @role.id, user_id: @user_id
        @user_list = Datacentred::Role.users(@role.id)
        assert_equal @user_list.count, 1
        assert Datacentred::Role.remove_user role_id: @role.id, user_id: @user_id
        @new_user_list = Datacentred::Role.users(@role.id)
        assert_equal @new_user_list.count, 0
      end
    end

    def test_remove_user_from_role_instance_method
      VCR.use_cassette('remove_user_from_role_instance_method') do
        @role = Datacentred::Role.create(@create_params1)
        @user = Datacentred::User.all.first
        @role.add_user @user
        assert_equal @role.users.count, 1
        assert @role.remove_user @user
        assert_equal @role.users.count, 0
      end
    end

    def test_remove_user_from_role_not_found_class_method
      VCR.use_cassette('remove_user_from_role_not_found') do
        @role = Datacentred::Role.create(@create_params1)
        assert_raises(Datacentred::Errors::NotFound) do
          Datacentred::Role.remove_user role_id: @role.id, user_id: "unknown"
        end
      end
    end

    def test_remove_user_from_role_not_found_instance_method
      VCR.use_cassette('remove_user_from_role_not_found') do
        @role = Datacentred::Role.create(@create_params1)
        assert_raises(Datacentred::Errors::NotFound) do
          @role.remove_user Datacentred::User.new id: "unknown"
        end
      end
    end
  end
end
