defmodule Sneakers23.TestingTest do
  use Sneakers23.DataCase

  alias Sneakers23.Testing

  describe "tests" do
    alias Sneakers23.Testing.Test

    import Sneakers23.TestingFixtures

    @invalid_attrs %{}

    test "list_tests/0 returns all tests" do
      test = test_fixture()
      assert Testing.list_tests() == [test]
    end

    test "get_test!/1 returns the test with given id" do
      test = test_fixture()
      assert Testing.get_test!(test.id) == test
    end

    test "create_test/1 with valid data creates a test" do
      valid_attrs = %{}

      assert {:ok, %Test{} = test} = Testing.create_test(valid_attrs)
    end

    test "create_test/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Testing.create_test(@invalid_attrs)
    end

    test "update_test/2 with valid data updates the test" do
      test = test_fixture()
      update_attrs = %{}

      assert {:ok, %Test{} = test} = Testing.update_test(test, update_attrs)
    end

    test "update_test/2 with invalid data returns error changeset" do
      test = test_fixture()
      assert {:error, %Ecto.Changeset{}} = Testing.update_test(test, @invalid_attrs)
      assert test == Testing.get_test!(test.id)
    end

    test "delete_test/1 deletes the test" do
      test = test_fixture()
      assert {:ok, %Test{}} = Testing.delete_test(test)
      assert_raise Ecto.NoResultsError, fn -> Testing.get_test!(test.id) end
    end

    test "change_test/1 returns a test changeset" do
      test = test_fixture()
      assert %Ecto.Changeset{} = Testing.change_test(test)
    end
  end
end
