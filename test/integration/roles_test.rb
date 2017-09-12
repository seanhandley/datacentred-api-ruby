require_relative '../test_helper'

module Datacentred
  class RolesIntegrationTest < Minitest::Test
    def setup
      @create_params1      = {"role" => {"name" => "New Role"}}
      @create_params2      = {"role" => {"name" => "Historical Figures",
                              "permissions" => ["usage.read","tickets.modify"]}}
      @new_permissions     = {"role" => {"permissions" => ['usage.read',
                              'roles.modify', 'roles.read']}}
      @invalid_permissions = {"role" => {"name" => "Genghis Khan",
                              "permissions" => ["fighting"]}}
      @update_params       = {"role" => {"name" => "Administrator 2"}}
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
        assert_raises(Datacentred::UnprocessableEntity) do
          @role = Datacentred::Role.create(@invalid_permissions)
        end
      end
    end

    def test_update_role
      VCR.use_cassette('update_role') do
        @role = Datacentred::Role.create(@create_params1)
        assert_equal @role.name, 'New Role'
        @updated_role = Datacentred::Role.update(@role.id, @update_params)
        assert_equal @updated_role.name, 'Administrator 2'
      end
    end

    def test_update_role_with_invalid_permissions
      VCR.use_cassette('update_role_with_invalid_permissions') do
        @role = Datacentred::Role.create(@create_params1)
        assert_raises(Datacentred::UnprocessableEntity) do
          Datacentred::Role.update(@role.id, @invalid_permissions)
        end
      end
    end

    def test_delete_role
      VCR.use_cassette('delete_role') do
        @role = Datacentred::Role.create(@create_params1)
        assert Datacentred::Role.find(@role.id)
        Datacentred::Role.delete(@role.id)
        assert_raises(Datacentred::NotFoundError) do
          @role = Datacentred::Role.find(@role.id)
        end
      end
    end

    def test_list_role_users
      VCR.use_cassette('list_role_users') do
        @role = Datacentred::Role.create(@create_params1)
        @user_list = Datacentred::Role.users(@role.id)
        assert_equal @user_list.count, 0
      end
    end

    def test_add_user_to_role
      VCR.use_cassette('add_user_to_role') do
        @role = Datacentred::Role.create(@create_params1)
        @user_list = Datacentred::Role.users(@role.id)
        assert_equal @user_list.count, 0
        Datacentred::Role.add_user(@role.id, @user_id)
        @new_users_list = Datacentred::Role.users(@role.id)
        assert_equal @new_users_list.count, 1
        assert_equal @new_users_list.first.id, @user_id
      end
    end

    def test_remove_user_from_role
      VCR.use_cassette('remove_user_from_role') do
        @role = Datacentred::Role.create(@create_params1)
        Datacentred::Role.add_user(@role.id, @user_id)
        @user_list = Datacentred::Role.users(@role.id)
        assert_equal @user_list.count, 1
        Datacentred::Role.remove_user(@role.id, @user_id)
        @new_user_list = Datacentred::Role.users(@role.id)
        assert_equal @new_user_list.count, 0
      end
    end

    def test_remove_user_from_role_not_found
      VCR.use_cassette('remove_user_from_role_not_found') do
        @role = Datacentred::Role.create(@create_params1)
        assert_raises(Datacentred::NotFoundError) do
          Datacentred::Role.remove_user(@role.id, "unknown")
        end
      end
    end
  end
end
