defmodule ExpoEscomWeb.ActividadLive.Show do
  use ExpoEscomWeb, :live_view

  import ExpoEscomWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Actividad {@actividad.id}
      <:subtitle>This is a actividad record from your database.</:subtitle>

      <:actions>
        <.link patch={~p"/actividades/#{@actividad}/show/edit"} phx-click={JS.push_focus()}>
          <.button>Edit actividad</.button>
        </.link>
      </:actions>
    </.header>

    <.list>
      <:item title="Id">{@actividad.id}</:item>

      <:item title="Nombre">{@actividad.nombre}</:item>
    </.list>

    <.back navigate={~p"/actividades"}>Back to actividades</.back>

    <.modal
      :if={@live_action == :edit}
      id="actividad-modal"
      show
      on_cancel={JS.patch(~p"/actividades/#{@actividad}")}
    >
      <.live_component
        module={ExpoEscomWeb.ActividadLive.FormComponent}
        id={@actividad.id}
        title={@page_title}
        action={@live_action}
        current_user={@current_user}
        actividad={@actividad}
        patch={~p"/actividades/#{@actividad}"}
      />
    </.modal>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(
       :actividad,
       Ash.get!(ExpoEscom.Eventos.Actividad, id, actor: socket.assigns.current_user)
     )}
  end

  defp page_title(:show), do: "Show Actividad"
  defp page_title(:edit), do: "Edit Actividad"
end
