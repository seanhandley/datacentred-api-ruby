require_relative '../test_helper'

module Datacentred
  class ProjectsIntegrationTest < Minitest::Test
    def setup
      @params_with_new_name = {name: "new_project_name"}
      @create_params        = {name: "test_new_project"}
      @user_id              = "user_id"
      @project_id           = 'project_id1'
      @project_id2          = 'project_id2'
    end

    def test_list_projects
      VCR.use_cassette('list_projects') do
        @projects = Datacentred::Project.all
        assert_equal 1, @projects.count
        @project = @projects.first
        assert @project.id
      end
    end

    def test_show_project
      VCR.use_cassette('show_project') do
        @project = Datacentred::Project.find(@project_id)
        assert_equal @project.name, "foo_bar_primary"
      end
    end

    def test_raises_not_found_if_project_doesnt_exist
      VCR.use_cassette('project_not_found') do
        assert_raises(Datacentred::Errors::NotFound) do
          @project = Datacentred::Project.find("unknown")
        end
      end
    end

    def test_create_project
      VCR.use_cassette('create_project') do
        @new_project = Datacentred::Project.create(@create_params)
        assert_equal @new_project.name, "test_new_project"
      end
    end

    def test_raises_unprocessable_entity_if_failed_validation_for_create
      VCR.use_cassette('project_create_failed_validation') do
        assert_raises(Datacentred::Errors::UnprocessableEntity) do
          Datacentred::Project.create(@create_params)
        end
      end
    end

    def test_update_project_with_class_method
      VCR.use_cassette('update_project') do
        @updated_project = Datacentred::Project.update(@project_id2, @params_with_new_name)
        assert_equal @updated_project.name, "test_new_project_name"
      end
    end

    def test_update_project_with_instance_method
      VCR.use_cassette('update_project_with_instance_method') do
        new_name = "ed020233e807a97cbb90b79129659e45"
        @project = Datacentred::Project.create(name: "987ed020233e807a97cbb90b7912965")
        @project.name = new_name
        @project.save
        assert_equal new_name, Datacentred::Project.find(@project.id).name
      end
    end

    def test_raises_unprocessable_entity_if_failed_validation_for_update
      VCR.use_cassette('project_update_failed_validation') do
        @params_with_used_name = {name: "foo"}
        assert_raises(Datacentred::Errors::UnprocessableEntity) do
          @project = Datacentred::Project.update(@project_id2, @params_with_used_name)
        end
      end
    end

    def test_delete_project_with_class_method
      VCR.use_cassette('delete_project') do
        Datacentred::Project.destroy(@project_id2)
        assert_raises(Datacentred::Errors::NotFound) do
          @project = Datacentred::Project.find(@project_id2)
        end
      end
    end

    def test_delete_project_with_instance_method
      VCR.use_cassette('delete_project_with_instance_method') do
        @project = Datacentred::Project.create(name: SecureRandom.hex)
        assert @project.destroy
        assert_raises(Datacentred::Errors::NotFound) do
          @project = Datacentred::Project.find(@project_id2)
        end
      end
    end

    def test_list_project_users_with_class_method
      VCR.use_cassette('list_project_users') do
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 2
        @user = @user_list.first
      end
    end

    def test_list_project_users_with_instance_method
      VCR.use_cassette('list_project_users_with_instance_method') do
        @project = Datacentred::Project.create(name: SecureRandom.hex)
        assert_equal 0, @project.users.count
      end
    end

    def test_add_user_to_project_with_class_method
      VCR.use_cassette('add_user_to_project') do
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 1
        assert Datacentred::Project.add_user project_id: @project_id, user_id: @user_id
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 2
      end
    end

    def test_add_remove_user_to_project_with_instance_method
      VCR.use_cassette('add_remove_user_to_project_with_instance_method') do
        @project = Datacentred::Project.all.first
        @user = Datacentred::User.create email: 'foo@barbazboom.com', password: SecureRandom.hex
        assert_equal 9, @project.users.count
        assert @project.add_user @user
        assert_equal 10, @project.users.count
        assert @project.remove_user @user
        assert_equal 9, @project.users.count
      end
    end

    def test_remove_user_from_project
      VCR.use_cassette('remove_user_from_project') do
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 2
        assert Datacentred::Project.remove_user project_id: @project_id, user_id: @user_id
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 1
      end
    end
  end
end
