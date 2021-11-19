defmodule AppWeb.UserRegistrationController do
  use AppWeb, :controller

  alias App.Accounts
  alias App.Accounts.User
  # alias AppWeb.UserAuth

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(
          :info,
          "User created successfully. Please check your email for confirmation instructions."
        )
        # |> UserAuth.log_in_user(user)
        # no longer log the user in upon registation
        |> redirect(to: Routes.user_session_path(conn, :new))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
