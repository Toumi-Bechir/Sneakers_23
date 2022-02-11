defmodule Sneakers23Web.TestController do
  use Sneakers23Web, :controller

  alias Sneakers23.Testing
  alias Sneakers23.Testing.Test

  def index(conn, _params) do
    tests = Testing.list_tests()
    render(conn, "index.html", tests: tests)
  end

  def new(conn, _params) do
    changeset = Testing.change_test(%Test{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"test" => test_params}) do
    case Testing.create_test(test_params) do
      {:ok, test} ->
        conn
        |> put_flash(:info, "Test created successfully.")
        |> redirect(to: Routes.test_path(conn, :show, test))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    test = Testing.get_test!(id)
    render(conn, "show.html", test: test)
  end

  def edit(conn, %{"id" => id}) do
    test = Testing.get_test!(id)
    changeset = Testing.change_test(test)
    render(conn, "edit.html", test: test, changeset: changeset)
  end

  def update(conn, %{"id" => id, "test" => test_params}) do
    test = Testing.get_test!(id)

    case Testing.update_test(test, test_params) do
      {:ok, test} ->
        conn
        |> put_flash(:info, "Test updated successfully.")
        |> redirect(to: Routes.test_path(conn, :show, test))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", test: test, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    test = Testing.get_test!(id)
    {:ok, _test} = Testing.delete_test(test)

    conn
    |> put_flash(:info, "Test deleted successfully.")
    |> redirect(to: Routes.test_path(conn, :index))
  end
end
