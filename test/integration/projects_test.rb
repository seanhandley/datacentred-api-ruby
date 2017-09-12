require_relative '../test_helper'

module Datacentred
  class ProjectsIntegrationTest < Minitest::Test
    def setup
      @params_with_new_name = {"project" =>{"name" => "new_project_name"}}
      @create_params        = {"project" => {"name" => "test_new_project"}}
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
        assert_raises(Datacentred::NotFoundError) do
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
        assert_raises(Datacentred::UnprocessableEntity) do
          Datacentred::Project.create(@create_params)
        end
      end
    end

    def test_update_project
      VCR.use_cassette('update_project') do
        @updated_project = Datacentred::Project.update(@project_id2, @params_with_new_name)
        assert_equal @updated_project.name, "test_new_project_name"
      end
    end

    def test_raises_unprocessable_entity_if_failed_validation_for_update
      VCR.use_cassette('project_update_failed_validation') do
        @params_with_used_name = {"project" => {"name" => "foo"}}
        assert_raises(Datacentred::UnprocessableEntity) do
          @project = Datacentred::Project.update(@project_id2, @params_with_used_name)
        end
      end
    end

    def test_raises_not_found_if_cant_find_project_for_update
      VCR.use_cassette('project_update_not_found') do
        assert_raises(Datacentred::NotFoundError) do
          @project = Datacentred::Project.update("unknown", @params_with_new_name)
        end
      end
    end

    def test_delete_project
      VCR.use_cassette('delete_project') do
        Datacentred::Project.delete(@project_id2)
        assert_raises(Datacentred::NotFoundError) do
          @project = Datacentred::Project.find(@project_id2)
        end
      end
    end

    def test_list_project_users
      VCR.use_cassette('list_project_users') do
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 2
        @user = @user_list.first
        assert @user.id
        assert @user.first_name
        assert @user.last_name
        assert @user.email
      end
    end

    def test_add_user_to_project
      VCR.use_cassette('add_user_to_project') do
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 1
        Datacentred::Project.add_user(@project_id, @user_id)
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 2
      end
    end

    def test_remove_user_from_project
      VCR.use_cassette('remove_user_from_project') do
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 2
        Datacentred::Project.remove_user(@project_id, @user_id)
        @user_list = Datacentred::Project.users(@project_id)
        assert_equal @user_list.count, 1
      end
    end
  end
end
