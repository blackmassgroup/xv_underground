defmodule VxUndergroundWeb.AccountLive.User.Index do
  use VxUndergroundWeb, :live_view

  alias VxUnderground.Accounts
  alias VxUnderground.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:users, list_users())
      |> assign(:roles, Accounts.list_roles() |> Enum.map(&[value: &1.id, key: &1.name]))

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Role")
    |> assign(:user, Accounts.get_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:user, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)

    {:ok, _} = Accounts.delete_user(user)

    {:noreply, assign(socket, :users, list_users())}
  end

  defp list_users do
    Accounts.list_users()
  end
end
