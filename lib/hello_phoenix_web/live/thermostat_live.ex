defmodule HelloPhoenixWeb.ThermostatLive do
  use HelloPhoenixWeb, :live_view
  alias HelloPhoenixWeb, as: Web
  alias HelloPhoenix.HelloPhoenixWeb

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <h1 class="font-bold text-3xl">Features</h1>
      <div class="space-y-3">
        <%= for flag_state <- @flags do %>
          <.live_component module={Web.FeatureLive} id={flag_state.id} flag_state={flag_state} />
        <% end %>
      </div>
    </div>
    """
  end

  def mount(params, _session, socket) do
    environment = HelloPhoenixWeb.get_environment(params[:environment])
    flags = HelloPhoenixWeb.compute_flags(%{:environment_key => environment.key})

    Web.Endpoint.subscribe("flags")

    {:ok, assign(socket, :flags, flags) |> assign(:environment, environment)}
  end

  def handle_info(
        %{
          topic: "flags",
          event: "flag_state_changed",
          payload: %{:id => id, :enabled => enabled}
        },
        socket
      ) do
    new_flags =
      Enum.map(socket.assigns.flags, fn flag_state ->
        case flag_state.id do
          ^id -> Map.put(flag_state, :enabled, enabled)
          _ -> flag_state
        end
      end)

    {:noreply, assign(socket, :flags, new_flags)}
  end
end
