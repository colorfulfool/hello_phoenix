defmodule HelloPhoenixWeb.FeatureLive do
  use Phoenix.LiveComponent

  import HelloPhoenixWeb.FlagComponents
  alias HelloPhoenixWeb, as: Web
  alias HelloPhoenix.HelloPhoenixWeb

  def render(assigns) do
    ~H"""
    <div class="flex justify-between">
      <div>
        <div class="font-bold">{@flag_state.flag.name}</div>
        <div>{@flag_state.flag.description}</div>
      </div>
      <.toggle enabled={@flag_state.enabled} phx-click="toggle" phx-target={@myself} />
    </div>
    """
  end

  def handle_event("toggle", _params, socket) do
    id = socket.assigns.flag_state.id
    new_enabled = !socket.assigns.flag_state.enabled

    HelloPhoenixWeb.set_flag_state_enabled(id, new_enabled)
    Web.Endpoint.broadcast("flags", "flag_state_changed", %{:id => id, :enabled => new_enabled})

    {:noreply, socket}
  end
end
