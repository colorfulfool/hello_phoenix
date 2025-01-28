defmodule HelloPhoenixWeb.LiveHelpers do
  def live_collection(conn, collection, component) do
    Phoenix.LiveView.Controller.live_render(conn, HelloPhoenixWeb.CollectionLive,
      session: %{"collection" => collection, "component" => component}
    )
  end
end
