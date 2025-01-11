defmodule HelloPhoenixWeb.EnvironmentFeaturesLive do
  use Phoenix.LiveView
  alias HelloPhoenixWeb, as: Web
  alias HelloPhoenix.HelloPhoenixWeb

  def render(assigns) do
    ~H"""
    <div class="space-y-3">
      <%= for flag_state <- @flags do %>
        <.live_component module={Web.FeatureLive} id={flag_state.id} flag_state={flag_state} />
      <% end %>
    </div>
    """
  end

  def mount(:not_mounted_at_router, %{"environment_id" => environment_id}, socket) do
    flags = HelloPhoenixWeb.compute_flags(%{:environment_id => environment_id})
    Web.Endpoint.subscribe("flags")
    {:ok, assign(socket, :flags, flags)}
  end

  def handle_info(
        %{
          topic: "flags",
          event: "flag_state_changed",
          payload: payload
        },
        socket
      ) do
    {%{id: id}, attributes} = Map.split(payload, [:id])

    new_flags =
      Enum.map(socket.assigns.flags, fn flag_state ->
        case flag_state.id do
          ^id -> Map.merge(flag_state, attributes)
          _ -> flag_state
        end
      end)

    {:noreply, assign(socket, :flags, new_flags)}
  end
end
